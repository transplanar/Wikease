module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      # sign_in FactoryGirl.create(:admin) # Using factory girl as an example
      user = User.create!(email: "admin_test@example.com", password: "password", confirmed_at: Time.now, role: 'admin')
      sign_in user

      # sign_in User.create!()

      # sign_in User.create!(email: "admin_test@example.com", password: "password", confirmed_at: Time.now, role: 'admin')
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      # user = FactoryGirl.create(:user)
      user = User.create!(email: "member_test@example.com", password: "password", confirmed_at: Time.now, role: 'member')
      # user.confirm!
      sign_in user
    end
  end
end
