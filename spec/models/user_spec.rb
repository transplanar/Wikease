require 'rails_helper'

RSpec.describe User, type: :model do
  let(:my_user){User.create!(email: "test@example.com", password: "password", confirmed_at: Time.now)}

  describe 'associations' do
    it{ should have_many(:wikis)}
    it{ should have_many(:collaborations)}
  end

  describe 'attributes' do
    let(:user) { User.create!(email: 'test@user.com', password: 'loljkthxbai') }

    it 'should respond to role' do
      expect(my_user).to respond_to(:role)
    end

    it 'should respond to admin?' do
      expect(my_user).to respond_to(:admin?)
    end

    it 'should respond to member?' do
      expect(my_user).to respond_to(:member?)
    end
  end

  describe 'roles' do
    it 'should be member by default' do
      expect(my_user.role).to eql('member')
    end

    context 'member my_user' do
      it 'should return true for #member?' do
        expect(my_user.member?).to be_truthy
      end

      it 'should return false for #admin?' do
        expect(my_user.admin?).to be_falsey
      end
    end

    context 'admin my_user' do
      before do
        my_user.admin!
      end

      it 'should return false for #member?' do
        expect(my_user.member?).to be_falsey
      end

      it 'should return true for #admin?' do
        expect(my_user.admin?).to be_truthy
      end
    end

    context '#downgrade_role' do
      before do
        my_user.admin!
        my_user.downgrade_role
      end

      it 'should revert user back to member role' do
        expect(my_user.admin?).to be_falsey
      end
    end
  end
end
