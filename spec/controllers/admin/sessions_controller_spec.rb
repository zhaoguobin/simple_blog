require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do

  describe "GET #new" do
    context "as a guest" do
      it "responds successfully" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

end
