class WikiPolicy < ApplicationPolicy
	def show?
		user.present? && (user.premium? || user == record.user)
	end

	def create?
		show?
	end

	def edit?
		show?
	end

  def destroy?
    user == record.user && user.present?
  end
end
