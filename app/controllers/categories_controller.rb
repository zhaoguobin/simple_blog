class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find params[:id]
    @articles = @category.published_articles.includes(:category, :tags).page(params[:page])
  end
end
