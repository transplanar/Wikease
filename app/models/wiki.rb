class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  validates :title, presence: true
  validates :body, presence: true

  def collaboration_for(user)
    collaborations.find_by(user: user)
  end
end
