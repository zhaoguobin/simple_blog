require 'rails_helper'
require 'support/login_support'

RSpec.describe Admin::ArticlesController, type: :controller do
  include LoginSupport
  validate_login_required [
    {get: :index},
    {get: :new},
    {post: :create},
    {get: :show, params: {id: 1}},
    {get: :edit, params: {id: 1}},
    {patch: :update, params: {id: 1}},
    {delete: :destroy, params: {id: 1}},
    {patch: :publish, params: {id: 1}},
    {patch: :unpublish, params: {id: 1}}
  ]

  context "as an anthencated user" do
    before do
      sign_in
    end

    describe "GET #index" do
      it "responds successfully" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "responds successfully" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST #create" do
      it "add a article" do
        category = Category.create(name: 'category 1')
        expect {
          post :create, params: {article: {title: 'article 1', category_id: category.id}}
        }.to change(Article.all, :count).by(1)
      end
    end

    describe "GET #show" do
      it "responds successfully" do
        category = Category.create(name: 'category 1')
        article = Article.create(title: 'article 1', category_id: category.id)
        get :show, params: {id: article.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "responds successfully" do
        category = Category.create(name: 'category 1')
        article = Article.create(title: 'article 1', category_id: category.id)
        get :edit, params: {id: article.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "PATCH #update" do
      it "upates a article" do
        category = Category.create(name: 'category 1')
        article = Article.create(title: 'article 1', category_id: category.id)
        patch :update, params: {id: article.id, article: {title: 'article 2'}}
        expect(article.reload.title).to eq 'article 2'
      end
    end

    describe "DELETE #destroy" do
      it "deletes a article" do
        category = Category.create(name: 'category 1')
        article = Article.create(title: 'article 1', category_id: category.id)
        expect {
          delete :destroy, params: { id: article.id }
        }.to change(Article.all, :count).by(-1)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to("/admin/articles")
      end
    end

    describe "PATCH #publish" do
      it "has a published time after be published" do
        category = Category.create(name: 'category 1')
        article = Article.create(title: 'article 1', category_id: category.id, published_at: nil)
        patch :publish, params: {id: article.id}, format: :js
        expect(article.reload.published_at).not_to be nil
      end
    end

    describe "PATCH #unpublish" do
      it "doesn't have a published time after be unpublished" do
        category = Category.create(name: 'category 1')
        article = Article.create(title: 'article 1', category_id: category.id, published_at: Time.now)
        patch :unpublish, params: {id: article.id}, format: :js
        expect(article.reload.published_at).to be nil
      end
    end

  end

end
