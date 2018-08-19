require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "GET #show" do
    it "responds successfully" do
      tag_group = TagGroup.create(name: 'tag group 1')
      tag = Tag.create(name: 'tag 1', tag_group_id: tag_group.id)
      get :show, params: {id: tag.id}
      expect(response).to have_http_status(:success)
    end
  end
end
