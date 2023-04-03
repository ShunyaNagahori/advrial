class AdvrialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_advrial, only: [:edit, :update, :show, :destroy]

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
    if params[:advrial][:main_visual].present?
      if @advrial.save
        flash[:notice] = '作成しました'
        redirect_to advrial_path(@advrial)
      end
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
  end
  
  private
    def set_advrial
      @advrial = Advrial.find(params[:id])
    end

    def advrial_params
      params.require(:advrial).permit(
        :title,
        :start_date,
        :end_date,
        :description,
        :advrial_category_id,
        :main_visual
      )
    end
end
