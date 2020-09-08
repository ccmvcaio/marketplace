class Enterprise < ApplicationRecord

  before_create :set_email_domain

  private

  def set_email_domain
    self.domain = self.email.split("@")[1]
  end
end
