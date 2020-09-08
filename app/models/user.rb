class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :recoverable
  devise :database_authenticatable, :registerable, :validatable, :rememberable
  has_one :enterprise

  before_create :set_email_domain

  private
  
  def set_email_domain
    self.email_domain = self.email.split("@")[1]
  end
end
