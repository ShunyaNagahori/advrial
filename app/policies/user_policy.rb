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
end
