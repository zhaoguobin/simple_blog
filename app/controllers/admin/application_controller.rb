class Admin::ApplicationController < ApplicationController
  layout 'admin'

  helper_method :admin_login?
  before_action :admin_login_required

  private

  def admin_login?
    session[:admin_username].present?
  end

  def admin_login_required
    redirect_to admin_login_path and return unless admin_login?
  end
end
