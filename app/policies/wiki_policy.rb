class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  # REVIEW is this correct? (check based on wiki, not user authorization)
  def update?
    true
  end

end
