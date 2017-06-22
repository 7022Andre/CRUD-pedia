class CollaboratorPolicy < ApplicationPolicy
  def create?
  	user.present? && (user.premium? || user.admin?)
  end

  def destroy?
  	create?
  end
end
