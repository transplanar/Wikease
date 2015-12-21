class Wiki < ActiveRecord::Base
  belongs_to :user
  # REVIEW does this work?
  # belongs_to :owner, class_name: 'User'
  has_many :collaborations
  has_many :collaborators, class_name: 'User', source: :user, through: :collaborations
  # has_many :users, through: :collaborations
  # has_many :collaborators, class_name: 'User', through: :collaborations
end
