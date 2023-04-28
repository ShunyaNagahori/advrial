class SearchController < ApplicationController
  before_action :authenticate_user!
  
  def user
    @q = User.ransack(params[:q])
  end

  def advrial
    @q = Advrial.ransack(params[:q])
  end

  def result_users
    if params[:q][:account_name_or_name_cont].present?
      params[:q][:account_name_or_name_cont].gsub!("@", "")
    end
    @q = User.ransack(params[:q])
    @results = @q.result
  end


  def result_advrials
    @q = Advrial.ransack(params[:q])
    @results = @q.result
  end
end
