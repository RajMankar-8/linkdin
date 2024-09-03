class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @q = User.ransack(params[:q]) 
    @users = @q.result.limit(20).order(created_at: :asc)
  end
end
