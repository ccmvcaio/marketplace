class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
  end

  def show
    @profile = Profile.find(params[:id])
  end
end