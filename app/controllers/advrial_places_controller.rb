class AdvrialPlacesController < ApplicationController
  before_action :set_advrial
  before_action :set_places

  def edit
  end

  def update
    if @advrial.update(advrial_place_params)
      flash[:notice] = "placeを追加しました"
      redirect_to advrial_path(@advrial)
    else
      flash[:alert] = "placeの追加に失敗しました"
      render :edit, status: 422
    end
  end

  private

    def set_advrial
      @advrial = Advrial.find(params[:advrial_id])
    end

    def set_places
      @places = @advrial.user.places
    end

    def advrial_place_params
      params.require(:advrial).permit(place_ids: [])
    end
end
