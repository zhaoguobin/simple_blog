require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #show" do
    it "responds successfully" do
      category = Category.create(name: 'category 1')
      get :show, params: {id: category.id}
      expect(response).to have_http_status(:success)
    end
  end
end
