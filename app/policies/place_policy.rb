class PlacePolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    user == record.user
  end

  def edit?
    update?
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end
end
