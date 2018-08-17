class Admin::CategoriesController < Admin::ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Created successfully!"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Updated successfully!"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  private

  def find_category
    @category = Category.friendly.find params[:id]
  end

  def category_params
    params.require(:category).permit(:name, :avatar, :description)
  end
end
