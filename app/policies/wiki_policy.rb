# NOTE Could use "rails g pundit:policy Wiki" instead1
class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  # TODO add case for admin and/or higher level roles
  def update?
    (not wiki.private) || (@user == wiki.user)
  end
end
