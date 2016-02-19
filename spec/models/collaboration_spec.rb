require 'rails_helper'

RSpec.describe Collaboration, type: :model do
  describe 'associations' do
    it { should belong_to(:wiki) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
  end
end
