class TagsController < ApplicationController
  def show
    @tag = Tag.friendly.find params[:id]
    @articles = @tag.published_articles.includes(:category, :tags).page(params[:page])
  end
end
