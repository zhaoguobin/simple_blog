class Admin::ArticlesController < Admin::ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  before_action :load_categories_and_tags, only: [:new, :create, :edit, :update]

  def index
    @articles = Article.includes(:category).all.page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      flash[:success] = "Created successfully!"
      redirect_to admin_articles_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = "Updated successfully!"
      redirect_to admin_articles_path
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path
  end

  def publish
    @article.publish
  end

  def unpublish
    @article.unpublish
    render :publish
  end

  private

  def find_article
    @article = Article.friendly.find params[:id]
  end

  def load_categories_and_tags
    @categories = Category.all
    @tags = Tag.all
  end

  def article_params
    params.require(:article).permit(:title, :avatar, :abstract, :body, :category_id, tag_ids: [])
  end
end
