class UserPolicy < ApplicationPolicy
  def index
  	user.present? && (user.premium? || user.admin?)
  end

  def show?
  	user == record
  end

  def update
  	show?
  end
end
