class Admin::TagsController < Admin::ApplicationController
  before_action :find_tag, only: [:show, :edit, :update, :destroy]
  before_action :load_tag_groups, only: [:new, :create, :edit, :update]

  def index
    @tags = Tag.includes(:tag_group).all.page(params[:page])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new tag_params
    if @tag.save
      flash[:success] = "Created successfully!"
      redirect_to admin_tags_path
    else
      render :new
    end
  end

  def show
    @articles = @tag.articles.page(params[:page])
  end

  def edit
  end

  def update
    if @tag.update_attributes(tag_params)
      flash[:success] = "Updated successfully!"
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path
  end

  private

  def find_tag
    @tag = Tag.friendly.find params[:id]
  end

  def load_tag_groups
    @tag_groups = TagGroup.all
  end

  def tag_params
    params.require(:tag).permit(:name, :avatar, :description, :tag_group_id)
  end
end
