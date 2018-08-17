require 'rails_helper'
require 'support/login_support'

RSpec.describe Admin::TagGroupsController, type: :controller do
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
      it "add a tag group" do
        expect {
          post :create, params: {tag_group: {name: 'tag group 1'}}
        }.to change(TagGroup.all, :count).by(1)
      end
    end

    describe "GET #show" do
      it "responds successfully" do
        tag_group = TagGroup.create(name: 'tag group 1')
        get :show, params: {id: tag_group.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "responds successfully" do
        tag_group = TagGroup.create(name: 'tag group 1')
        get :edit, params: {id: tag_group.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "PATCH #update" do
      it "upates a tag group" do
        tag_group = TagGroup.create(name: 'tag group 1')
        patch :update, params: {id: tag_group.id, tag_group: {name: 'tag group 2'}}
        expect(tag_group.reload.name).to eq 'tag group 2'
      end
    end

    describe "DELETE #destroy" do
      it "deletes a tag group" do
        tag_group = TagGroup.create(name: 'tag group 1')
        expect {
          delete :destroy, params: { id: tag_group.id }
        }.to change(TagGroup.all, :count).by(-1)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to("/admin/tag_groups")
      end
    end

  end
end
