require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:my_user){User.create!(email: "test@example.com", password: "password", confirmed_at: Time.now)}
  
  before :each do
    sign_in my_user
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_user.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
