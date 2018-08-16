require 'rails_helper'
require 'support/login_support'

RSpec.describe Admin::DashboardController, type: :controller do
  include LoginSupport

  describe "GET #index" do
    context "as a guest" do
      it "redirects to the admin/login page" do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to "/admin/login"
      end
    end

    context "as an authenticated user" do
      it "responds successfully" do
        sign_in
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

end
