require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "responds successfully" do
      category = Category.create(name: 'category 1')
      article = Article.create(title: 'test_article', category_id: category.id, published_at: Time.now)
      get :show, params: {id: article.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #feed" do
    it "responds successfully" do
      get :feed, format: :rss
      expect(response).to have_http_status(:success)
    end
  end

end
