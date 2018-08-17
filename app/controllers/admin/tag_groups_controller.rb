class Admin::TagGroupsController < Admin::ApplicationController
  before_action :find_tag_group, only: [:show, :edit, :update, :destroy]

  def index
    @tag_groups = TagGroup.all.page(params[:page])
  end

  def new
    @tag_group = TagGroup.new
  end

  def create
    @tag_group = TagGroup.new(tag_group_params)
    if @tag_group.save
      flash[:success] = "Created successfully!"
      redirect_to admin_tag_groups_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @tag_group.update_attributes(tag_group_params)
      flash[:success] = "Updated successfully!"
      redirect_to admin_tag_groups_path
    else
      render :edit
    end
  end

  def destroy
    @tag_group.destroy
    redirect_to admin_tag_groups_path
  end

  private

  def find_tag_group
    @tag_group = TagGroup.friendly.find params[:id]
  end

  def tag_group_params
    params.require(:tag_group).permit(:name)
  end
end
