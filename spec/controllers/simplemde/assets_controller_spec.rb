require 'rails_helper'
require 'support/login_support'

RSpec.describe Simplemde::AssetsController, type: :controller do
  include LoginSupport
  validate_login_required [
    {post: :create}
  ]
end
