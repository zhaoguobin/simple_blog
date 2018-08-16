require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do

  describe "GET #index" do
    context "as a guest" do
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status('302')
      end

      it "redirects to the admin/login page" do
        get :index
        expect(response).to redirect_to "/admin/login"
      end
    end
  end

end
