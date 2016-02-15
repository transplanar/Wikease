class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :collaborations
  has_many :wikis

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
