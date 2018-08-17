require 'rails_helper'
require 'support/login_support'

RSpec.describe Admin::DashboardController, type: :controller do
  include LoginSupport
  validate_login_required [{get: :index}]

  describe "GET #index" do
    context "as an authenticated user" do
      it "responds successfully" do
        sign_in
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

end
