class Profile < ApplicationRecord
  belongs_to :user

  validates :full_name, :social_name, :cpf, :birth_date,
            :department, :role, presence: true 
end
