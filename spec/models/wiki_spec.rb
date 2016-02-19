require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:my_user){User.create!(email: "test@example.com", password: "password", confirmed_at: Time.now)}
  let(:my_wiki){Wiki.create!(title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph)}

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:collaborations) }
    it { should have_many(:users).through(:collaborations) }
  end

  describe 'validations' do
    it{ should validate_presence_of(:title)}
    it{ should validate_presence_of(:body)}
  end

  describe 'find collaborations for user' do
    before do
      @collaboration = my_wiki.collaborations.create!(user_id: my_user.id)
    end

    it 'should retrieve collaborations that include my_user' do
      expect(my_wiki.collaboration_for(my_user)).to eq(@collaboration)
    end
  end
end
