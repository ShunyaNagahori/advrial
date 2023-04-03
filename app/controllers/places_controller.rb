class PlacesController < ApplicationController
  before_action :set_advrial
  before_action :set_place, only: [:show, :edit, :update, :destroy]

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
    if @place.update(place_params)
      flash[:notice] = '編集しました'
      redirect_to advrial_path(@advrial)
    else
      render :edit, status: 422
    end
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
        images: []
      )
    end

    def set_advrial
      @advrial = Advrial.find(params[:advrial_id])
    end

    def set_place
      @place = Place.find(params[:id])
    end

end
