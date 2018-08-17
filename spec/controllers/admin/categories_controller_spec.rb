require 'rails_helper'
require 'support/login_support'

RSpec.describe Admin::CategoriesController, type: :controller do
  include LoginSupport
  validate_login_required [
    {get: :index},
    {get: :new},
    {post: :create},
    {get: :show, params: {id: 1}},
    {get: :edit, params: {id: 1}},
    {patch: :update, params: {id: 1}},
    {delete: :destroy, params: {id: 1}}
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
      it "add a category" do
        expect {
          post :create, params: {category: {name: 'category 1'}}
        }.to change(Category.all, :count).by(1)
      end
    end

    describe "GET #show" do
      it "responds successfully" do
        category = Category.create(name: 'category 1')
        get :show, params: {id: category.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "responds successfully" do
        category = Category.create(name: 'category 1')
        get :edit, params: {id: category.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "PATCH #update" do
      it "upates a category" do
        category = Category.create(name: 'category 1')
        patch :update, params: {id: category.id, category: {name: 'category 2'}}
        expect(category.reload.name).to eq 'category 2'
      end
    end

    describe "DELETE #destroy" do
      it "deletes a category" do
        category = Category.create(name: 'category 1')
        expect {
          delete :destroy, params: { id: category.id }
        }.to change(Category.all, :count).by(-1)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to("/admin/categories")
      end
    end

  end
end
