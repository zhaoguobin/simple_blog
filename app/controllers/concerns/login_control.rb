module LoginControl
  extend ActiveSupport::Concern

  included do |base|
    base.helper_method :admin_login?
    base.before_action :admin_login_required
  end

  private

  def admin_login?
    session[:admin_username].present?
  end

  def admin_login_required
    redirect_to admin_login_path and return unless admin_login?
  end

end
