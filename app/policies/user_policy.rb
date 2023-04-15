class UserPolicy < ApplicationPolicy 
  def edit?
    user == record
  end

  def update?
    user == record
  end

  def destroy?
    user == record
  end

  def welcome?
    true
  end
end
