class PlacesController < ApplicationController

  def new
    @place = @advrial.places.new
  end

  def create
    @place = @advrial.places.new(place_params)

    if @place.save
      redirect_to @place.advrial
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
        :longitude
      )
    end

    def set_advrial
      @advrial = Advrial.find(params[:id])
    end

end
