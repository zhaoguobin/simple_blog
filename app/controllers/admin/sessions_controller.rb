class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :admin_login_required, only: [:new, :create]
  before_action :admin_logged_in_check, only: [:new, :create]

  def new

  end

  def create
    if admin_authenticate?
      login
      redirect_to admin_root_url
    else
      flash.now[:warning] = "Login failed!"
      render :new
    end
  end

  def destroy
    logout
    redirect_to '/'
  end

  private

  def admin_logged_in_check
    redirect_to admin_root_url and return if admin_login?
  end

  def login_params
    params.require(:admin).permit(:username, :password)
  end

  def admin_authenticate?
    src = Digest::SHA1.hexdigest("#{login_params[:username]}-#{login_params[:password]}")
    dst = Digest::SHA1.hexdigest("#{Rails.application.credentials[Rails.env.to_sym][:admin][:username]}-#{Rails.application.credentials[Rails.env.to_sym][:admin][:password]}")
    src == dst
  end

  def login
    session[:admin_username] = Rails.application.credentials[Rails.env.to_sym][:admin][:username]
  end

  def logout
    session.delete(:admin_username)
  end
end
