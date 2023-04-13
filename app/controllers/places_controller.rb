class PlacesController < ApplicationController
  before_action :set_advrial
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :corrent_user, except: [:show]

  def new
    @place = @advrial.places.new
  end

  def create
    @place = @advrial.places.new(place_params)

    if @place.save
      flash[:notice] = t('common.actions.create.created')
      redirect_to advrial_path(@advrial)
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      flash[:notice] = t('common.actions.edit.updated')
      redirect_to advrial_path(@advrial)
    else
      render :edit, status: 422
    end
  end

  def show
  end

  def destroy
    if @place.destroy
      flash[:notice] = t('common.actions.destroy.deleted')
      redirect_to advrial_path(@advrial)
    else
      render :edit, status: 422
    end
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

    def corrent_user
      unless @advrial.user == current_user
      flash[:alert] = "他のユーザーのページにはアクセス出来ません。"
      redirect_to root_path
      end
    end
end
