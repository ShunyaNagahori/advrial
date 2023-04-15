class PlacePolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    user == record.advrial.user
  end

  def edit?
    update?
  end

  def update?
    user == record.advrial.user
  end

  def destroy?
    user == record.advrial.user
  end
end
