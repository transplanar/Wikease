# NOTE Could use "rails g pundit:policy Wiki" instead1
class WikiPolicy < ApplicationPolicy
  def update?
    (not record.private) || (user == record.user) || (user.role == 'admin') || (record.users.include?(user))
  end

  def show?
    update?
  end

  def destroy?
    update?
  end

  class Scope
   attr_reader :user, :scope

   def initialize(user, scope)
     @user = user
     @scope = scope
   end

   def resolve
     wikis = []
     if user.role == 'admin'
       wikis = scope.all
     elsif user.role == 'premium'
       all_wikis = scope.all
       all_wikis.each do |wiki|
         if !wiki.private || wiki.user == user || wiki.users.include?(user)
           wikis << wiki
         end
       end
     else
       all_wikis = scope.all
       wikis = []
       all_wikis.each do |wiki|
         if !wiki.private || wiki.users.include?(user)
           wikis << wiki
         end
       end
     end
     wikis
   end
 end
end
