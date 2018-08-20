class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:category).published.page(params[:page])
    @carousel_articles = @categories.map {|category| category.published_articles.first}.compact
    @hot_tags = Tag.hot
  end

  def show
    @article = Article.includes(:category, :tags).published.friendly.find params[:id]
  end

  def feed
    @articles = Article.published
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
