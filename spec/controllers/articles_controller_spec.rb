require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
