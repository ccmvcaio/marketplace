class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
  
  def index
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to @profile
    else
      render :new
    end    
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private

  def profile_params
    params.require(:profile).permit(:full_name, :social_name, :cpf,
                                    :birth_date, :department, :role)
  end
end