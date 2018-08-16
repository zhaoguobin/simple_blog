class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :admin_login_required, only: [:new, :create]
  before_action :admin_logged_in_check, only: [:new, :create]

  def new

  end

  def create

  end

  def destroy

  end

  private

  def admin_logged_in_check
    redirect_to admin_root_url and return if admin_login?
  end
end
