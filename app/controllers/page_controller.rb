class PageController < ApplicationController
  before_action :authenticate_user!
  def index
    @advrials = (current_user.following.map{|user| user.advrials}.flatten.select{ |advrial| advrial.completed_trip && advrial.public } + current_user.advrials.where(completed_trip: true, public: true)).sort_by(&:returns_home_at).reverse
  end
end

