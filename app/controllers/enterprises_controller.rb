class EnterprisesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    user_domain = current_user.email_domain
    @enterprise = Enterprise.find_by(domain:(user_domain))
  end
end