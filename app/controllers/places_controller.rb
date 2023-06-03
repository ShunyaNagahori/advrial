class PlacesController < ApplicationController
  before_action :set_advrials
  before_action :set_user, only: [:index, :show]
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :authorize_record

  def index
    @places = @user.places.order(date_time: :desc)
  end

  def new
    @place = current_user.places.new
  end

  def create
    @place = current_user.places.new(place_params)
    if @place.save
      flash[:notice] = t('common.actions.create.created')
      redirect_to user_place_path(current_user, @place)
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def update
    # image_idsがparamsに含まれている場合、チェックされているものを削除する。
    if params[:place][:image_ids].present?
      params[:place][:image_ids].each do |image_id|
        image = @place.images.find(image_id)
        image.purge
      end
    end

    if @place.update(place_params)
      flash[:notice] = t('common.actions.edit.updated')
      redirect_to user_place_path(current_user, @place)
    else
      render :show, status: 422
    end
  end

  def show
  end

  def destroy
    if @place.destroy
      flash[:notice] = t('common.actions.destroy.deleted')
      redirect_to user_places_path(current_user)
    else
      render :edit, status: 422
    end
  end

  private

    def set_advrials
      @advrials = current_user.advrials
    end

    def set_place
      @place = Place.find(params[:id])
    end

    def authorize_record
      authorize @place || current_user.places.new
    end

    def set_user
      @user = User.find_by(account_name: params[:user_account_name])
    end

    def place_params
      params.require(:place).permit(
        :place_name,
        :date_time,
        :address,
        :latitude,
        :longitude,
        :description,
        :public,
        images: []
      )
    end
end
