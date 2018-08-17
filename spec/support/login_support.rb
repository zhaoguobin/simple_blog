module LoginSupport
  def self.included(base)
    base.extend(ClassMethods)
  end

  def sign_in
    session[:admin_username] = Rails.application.credentials[Rails.env.to_sym][:admin][:username]
  end

  module ClassMethods

    def validate_login_required(args)
      self.class_eval do
        args.each do |arg|
          describe "#{arg.keys.first.upcase} ##{arg.values.first}" do
            context "as a guest" do
              it "redirects to the admin/login page" do
                send(arg.keys.first, arg.values.first, {params: arg.values[1].to_h})
                expect(response).to have_http_status(:redirect)
                expect(response).to redirect_to "/admin/login"
              end
            end
          end
        end
      end
    end

  end
  
end
