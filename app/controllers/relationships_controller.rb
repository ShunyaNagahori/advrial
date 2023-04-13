class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.active_relationships.create!(followed_id: @user.id) if @user
    flash[:notice] = t('common.actions.follow')
    redirect_back(fallback_location: @user)
  end

  def destroy
    relationship = current_user.active_relationships.find_by(followed_id: @user.id)
    relationship&.destroy
    flash[:alert] = t('common.actions.unfollow')
    redirect_back(fallback_location: @user)
  end

  def followers
    @followers = @user.followers.all
  end

  def following
    @following = @user.following.all
  end

  private

    def set_user
      @user = User.find_by(account_name: params[:user_account_name])
    end
end
