class PlacesController < ApplicationController
  before_action :set_advrial, only: [:new, :create]

  def new
    @place = @advrial.places.new
  end

  def create
    @place = @advrial.places.new(place_params)

    if @place.save
      flash[:notice] = '作成しました'
      redirect_to root_path
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  private

    def place_params
      params.require(:place).permit(
        :place_name,
        :date_time,
        :address,
        :latitude,
        :longitude,
        :description,
        :images
      )
    end

    def set_advrial
      @advrial = Advrial.find(params[:advrial_id])
    end

end
