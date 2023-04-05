class AdvrialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_advrial, only: [:edit, :update, :show, :destroy, :completed]

  def index
    @advrials = current_user.advrials
  end

  def new
    @advrial = current_user.advrials.new
    @advrial_categories = AdvrialCategory.all
  end

  def create
    @advrial = current_user.advrials.new(advrial_params)
    @advrial_categories = AdvrialCategory.all
    if @advrial.save
      flash[:notice] = t('advrials.show.description')
      redirect_to advrial_path(@advrial)
    else
      render :new, status: 422
    end
  end

  def edit
    @advrial_categories = AdvrialCategory.all
  end

  def update
    @advrials = current_user.advrials
    @advrial_categories = AdvrialCategory.all
    if @advrial.update(advrial_params)
      render :index
    else
      render :edit, status: 422
    end
  end

  def show
    @places = @advrial.places.order(date_time: :desc)
  end

  def destroy
    if @advrial.destroy
      flash[:notice] = t('common.actions.destroy.deleted')
      redirect_to user_advrials_path(current_user)
    else
      render :edit, status: 422
    end
  end

  def completed
    if @advrial.update(completed_trip: true)
      flash[:notice] = "帰宅しました"
      redirect_to @advrial
    else
      flash[:alert] = "編集できません"
      render :show, status: 422
    end
  end
  
  private
    def set_advrial
      @advrial = current_user.advrials.find(params[:id])
    end

    def advrial_params
      params.require(:advrial).permit(
        :title,
        :start_date,
        :end_date,
        :description,
        :advrial_category_id,
        :main_visual,
      )
    end
end
