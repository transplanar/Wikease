require 'rails_helper'

RSpec.describe "Wikis", type: :request do
  # REVIEW why does this make a "wiki" and "wikis" spec file? Is it for API testing?
  describe "GET /wikis" do
    it "works! (now write some real specs)" do
      get wikis_path
      expect(response).to have_http_status(200)
    end
  end
end
