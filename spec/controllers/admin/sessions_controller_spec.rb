require 'rails_helper'
require 'support/login_support'

RSpec.describe Admin::SessionsController, type: :controller do
  include LoginSupport
  validate_login_required [{delete: :destroy}]

  describe "GET #new" do
    context "as a guest" do
      it "responds successfully" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context "as an authenticated user" do
      it "redirects to the admin/login page" do
        sign_in
        get :new
        expect(response).to redirect_to "/admin"
      end
    end
  end

  describe "POST #create" do
    context "as a guest" do
      it "responds successfully with admin parameters" do
        post :create, params: { admin: { username: 'admin', password: 'admin' } }
        expect(session[:admin_username]).to eq 'admin'
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to "/admin"
      end

      it "responds successfully with wrong username and wrong password" do
        post :create, params: { admin: { username: 'wrong_username', password: 'wrong_password' } }
        expect(response).to have_http_status(:success)
        expect(flash[:warning]).to eq "Login failed!"
      end

      it "responds successfully with wrong password" do
        post :create, params: { admin: { username: 'admin', password: 'wrong_password' } }
        expect(response).to have_http_status(:success)
        expect(flash[:warning]).to eq "Login failed!"
      end

      it "responds successfully with wrong username" do
        post :create, params: { admin: { username: 'wrong_username', password: 'admin' } }
        expect(response).to have_http_status(:success)
        expect(flash[:warning]).to eq "Login failed!"
      end
    end

    context "as an authenticated user" do
      it "redirects to the /admin page" do
        sign_in
        post :create
        expect(response).to redirect_to "/admin"
      end
    end
  end

  describe "DELETE #destroy" do
    context "as an authenticated user" do
      it "responds successfully" do
        sign_in
        delete :destroy
        expect(session[:admin_username]).to eq nil
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to "/"
      end
    end
  end

end
