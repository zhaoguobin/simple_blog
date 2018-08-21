class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  belongs_to :category, counter_cache: true
  has_and_belongs_to_many :tags, after_add: :increment_articles_count, after_remove: :decrement_articles_count
  
  validates :title, presence: true, uniqueness: true

  before_save :render_markdown
  after_save do
    self.delay.calculate_relation
  end
  before_destroy do
    self.tags.each do |tag|
      decrement_articles_count(tag)
    end
  end

  scope :published, -> { where.not(published_at: nil).order(published_at: :desc) }

  def published?
    published_at.present?
  end

  def publish
    update_attribute(:published_at, Time.now) unless published?
  end

  def unpublish
    update_attribute(:published_at, nil) if published?
  end

  def related_articles(limit = 5)
    related_ids = JSON.parse(related || '[]').collect {|a| a[0]}
    Article.where(id: related_ids).limit(limit)
  end

  protected

  def render_markdown
    body_str = self.body.to_s
    self.body_html = MARKDOWN.render(body_str)
    self.body_toc = TOC.render(body_str)
  end

  def increment_articles_count(tag)
    Tag.increment_counter(:articles_count, tag)
  end

  def decrement_articles_count(tag)
    Tag.decrement_counter(:articles_count, tag)
  end

  def calculate_relation
    Article.includes(:tags).each do |article|
      next if article.tag_ids.blank?
      relation = []
      Article.includes(:tags).each do |another_article|
        next if article == another_article || another_article.tag_ids.blank?
        tags_intersection_count = (article.tag_ids & another_article.tag_ids).count
        tags_union_count = (article.tag_ids | another_article.tag_ids).count
        relation << [another_article.id, (1 - (tags_intersection_count.to_f / tags_union_count)).round(3)]
      end
      relation.sort! {|a, b| a[1] <=> b[1]}
      article.update_column(:related, relation[0...20].to_json)
    end
  end

end
