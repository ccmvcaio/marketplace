class EnterprisesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    @enterprises = Enterprise.all
  end
end