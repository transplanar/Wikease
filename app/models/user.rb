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

  # REVIEW is this correct?
  def upgrade_role
    # REVIEW better way to increment? Is this sufficient?
    # self.role = 'vip'
    self.vip!

    # flash[:notice] = "#{self.email} account upgraded to #{current_user.role}."
  end

  def downgrade_role
    # self.role = 'memeber'
    self.member!

    # XXX save needed here?
    self.wikis.each do |wiki|
      wiki.private = false
    end
  end
end
