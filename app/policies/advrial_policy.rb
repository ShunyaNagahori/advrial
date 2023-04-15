class AdvrialPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end

  def completed?
    user == record.user
  end
end
