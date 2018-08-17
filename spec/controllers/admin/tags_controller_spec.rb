require 'rails_helper'
require 'support/login_support'

RSpec.describe Admin::TagsController, type: :controller do
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
      it "add a tag" do
        tag_group = TagGroup.create(name: 'tag group 1')
        expect {
          post :create, params: {tag: {name: 'tag 1', tag_group_id: tag_group.id}}
        }.to change(Tag.all, :count).by(1)
      end
    end

    describe "GET #show" do
      it "responds successfully" do
        tag_group = TagGroup.create(name: 'tag group 1')
        tag = Tag.create(name: 'tag 1', tag_group_id: tag_group.id)
        get :show, params: {id: tag.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "responds successfully" do
        tag_group = TagGroup.create(name: 'tag group 1')
        tag = Tag.create(name: 'tag 1', tag_group_id: tag_group.id)
        get :edit, params: {id: tag.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "PATCH #update" do
      it "upates a tag" do
        tag_group = TagGroup.create(name: 'tag group 1')
        tag = Tag.create(name: 'tag 1', tag_group_id: tag_group.id)
        patch :update, params: {id: tag.id, tag: {name: 'tag 2'}}
        expect(tag.reload.name).to eq 'tag 2'
      end
    end

    describe "DELETE #destroy" do
      it "deletes a tag" do
        tag_group = TagGroup.create(name: 'tag group 1')
        tag = Tag.create(name: 'tag 1', tag_group_id: tag_group.id)
        expect {
          delete :destroy, params: { id: tag.id }
        }.to change(Tag.all, :count).by(-1)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to("/admin/tags")
      end
    end

  end

end
