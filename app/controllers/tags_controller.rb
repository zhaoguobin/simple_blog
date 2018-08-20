class TagsController < ApplicationController
  def index
    @tag_groups = TagGroup.includes(:tags).all
  end

  def show
    @tag = Tag.friendly.find params[:id]
    @articles = @tag.published_articles.includes(:category, :tags).page(params[:page])
  end
end
