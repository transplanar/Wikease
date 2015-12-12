class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # TODO Improve email validation?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :wikis

  enum role: [:member, :vip, :admin]

  after_initialize :set_default_role

  def set_default_role
    self.role ||= "member"
  end
end
