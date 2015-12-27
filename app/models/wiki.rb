class Wiki < ActiveRecord::Base
  belongs_to :user
  # REVIEW does this work?
  # belongs_to :owner, class_name: 'User'
  has_many :collaborations
  has_many :users, through: :collaborations
  # has_many :users, through: :collaborations
  # has_many :collaborators, through: :collaborations, source: 

  def collaboration_for(user)
    collaborations.find_by(user: user)
  end
end
