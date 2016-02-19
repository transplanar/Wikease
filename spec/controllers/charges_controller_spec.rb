require 'rails_helper'
require 'stripe_mock'

RSpec.describe ChargesController, type: :controller do
  let(:my_user){User.create!(email: "test@example.com", password: "password", confirmed_at: Time.now)}

  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  it "creates a stripe customer" do
    customer = Stripe::Customer.create({
      email: 'johnny@appleseed.com',
      card: stripe_helper.generate_card_token
    })
    expect(customer.email).to eq('johnny@appleseed.com')
  end


  let(:expeced_btn_attributes){
    {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{my_user.email}",
      amount: Amount.default
    }
  }

  before :each do
    sign_in my_user
  end

  describe "GET #new" do
    it 'correctly sets stripe button data' do
      get :new

      expect(assigns(:stripe_btn_data)).to eq(expeced_btn_attributes)
    end

  end

  describe "GET #create" do
    it "returns http success" do
      card_token = StripeMock.generate_card_token(last4: "9191", exp_year: 1984)

      get :create, {card_token: card_token}
      expect(response).to redirect_to(my_user)
    end
  end
end
