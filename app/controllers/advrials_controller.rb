class AdvrialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:show]
  before_action :set_advrial, only: [:edit, :update, :show, :destroy, :completed]
  before_action :authorize_record

  def index
    if @user == current_user
      @advrials = @user.advrials.all.order(created_at: :desc)
    else
      @advrials = @user.advrials.where(public: true).order(created_at: :desc)
    end
  end

  def new
    @advrial = current_user.advrials.new
    @advrial_categories = AdvrialCategory.all
  end

  def create
    @advrial = current_user.advrials.new(advrial_params)
    @advrial_categories = AdvrialCategory.all
    if @advrial.save
      flash[:notice] = t('common.actions.create.created')
      redirect_to advrial_path(@advrial)
    else
      render :new, status: 422
    end
  end

  def edit
    @advrial_categories = AdvrialCategory.all
  end

  def update
    # turbo_frameを使っている為、以下のインスタンス変数が必要
    @advrials = current_user.advrials
    @advrial_categories = AdvrialCategory.all
    @user = current_user # params[:account_name]が取得できない為、current_userで設定
    if @advrial.update(advrial_params)
      flash[:notice] = t("common.actions.edit.updated")
      render :index
    else
      render :edit, status: 422
    end
  end

  def show
    if @advrial.user == current_user
      @places = @advrial.places.order(date_time: :desc)
    else 
      @places = @advrial.places.where(public: false).order(date_time: :desc)
    end
  end

  def destroy
    if @advrial.destroy
      flash[:notice] = t('common.actions.destroy.deleted')
      redirect_to user_advrials_path(current_user)
    else
      render :edit, status: 422
    end
  end
  
  private

    def set_advrial
      @advrial = Advrial.find(params[:id])
    end

    def authorize_record
      authorize @advrial || Advrial
    end

    def advrial_params
      params.require(:advrial).permit(
        :title,
        :start_date,
        :end_date,
        :description,
        :advrial_category_id,
        :public,
        :main_visual,
      )
    end

    def set_user
      @user = User.find_by(account_name: params[:user_account_name])
    end
end
