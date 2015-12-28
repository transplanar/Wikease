# NOTE Could use "rails g pundit:policy Wiki" instead1
class WikiPolicy < ApplicationPolicy
  # TODO add case for admin and/or higher level roles
  def update?
    # REVIEW 1 - what is the purpose of this VS using resolve?
    # (not record.private) || (user == record.user)
    (not record.private) || (user == record.user) || (user.role == 'admin') || (record.users.include?(user))
  end
  #
  # def index?
  #   update?
  # end
  #
  def show?
    update?
  end
  #
  # def destroy?
  #   update?
  # end

  class Scope
   attr_reader :user, :scope

   def initialize(user, scope)
     @user = user
     @scope = scope
   end

  #  REVIEW what is the purpose of this? This only applies to the index view?
   def resolve
     wikis = []
     if user.role == 'admin'
       wikis = scope.all # if the user is an admin, show them all the wikis
     elsif user.role == 'premium'
       all_wikis = scope.all
       all_wikis.each do |wiki|
        #  if wiki.public? || wiki.user == user || wiki.users.include?(user)
         if !wiki.private || wiki.user == user || wiki.users.include?(user)
           wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
         end
       end
     else # this is the lowly standard user
       all_wikis = scope.all
       wikis = []
       all_wikis.each do |wiki|
         if !wiki.private || wiki.users.include?(user)
           wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
         end
       end
     end
     wikis # return the wikis array we've built up
   end
 end
end
