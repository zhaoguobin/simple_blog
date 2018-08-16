module LoginSupport
  def sign_in
    session[:admin_username] = Rails.application.credentials[Rails.env.to_sym][:admin][:username]
  end
end
