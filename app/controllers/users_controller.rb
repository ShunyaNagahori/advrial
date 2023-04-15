class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]
  before_action :set_user, except: [:welcome]
  before_action :authorize_record

  def edit; end

  def update
    if params[:user][:account_name].blank?
      @user.errors.add(:account_name, :blank)
      render "edit", status: 422
    elsif
      @user.update(user_params)
      flash[:notice] = "更新されました"
      redirect_to @user
    else
      render "edit", status: 422
    end
  end

  def show; end

  def destroy
  end

  def welcome # 認証メール送信後のページ
  end

  private
    def set_user
      @user = User.find_by(account_name: params[:account_name])
    end

    def authorize_record
      authorize @user || User
    end

    def user_params
      params.require(:user).permit(
        :name,
        :email, 
        :account_name, 
        :url, 
        :date_of_birth, 
        :gender,
        :introduce,
        :password, 
        :password_confirmation,
        :image
      )
    end
end
