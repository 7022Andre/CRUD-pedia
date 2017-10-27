class WikiPolicy < ApplicationPolicy
  def show?
    user.present? && (user.premium? || user.admin? || user == record.user || record.collaborate_users.include?(user) )
  end

  def create?
    show?
  end

  def edit?
    show?
  end

  def destroy?
    user.present? && (user == record.user || user.admin?)
  end
end
