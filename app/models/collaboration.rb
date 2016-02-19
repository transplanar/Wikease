class Collaboration < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user

  # validates :wiki, presence: true
  validates :user, presence: true
end
