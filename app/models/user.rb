class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # TODO Improve email validation?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # has_many :wikis
  has_many :collaborations
  has_many :wikis, through: :collaborations
  has_many :collaborators, through: :collaborations

  enum role: [:member, :premium, :admin]

  after_initialize :set_default_role

  def set_default_role
    self.role ||= 'member'
  end

  def downgrade_role
    self.member!
    wikis.update_all(private: false)
  end
end
