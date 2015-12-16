# NOTE Could use "rails g pundit:policy Wiki" instead1
class WikiPolicy < ApplicationPolicy
  # TODO add case for admin and/or higher level roles
  def update?
    (not record.private) || (user == record.user)
  end

  def index?
    update?
  end

  def show?
    update?
  end
end
