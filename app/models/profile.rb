class Profile < ApplicationRecord
  belongs_to :user

  validates :full_name, :social_name, :cpf, :birth_date,
            :department, :role, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_must_be_valid
  has_many :products

  def cpf_must_be_valid
    if cpf.present? && !CPF.valid?(cpf, strict: true)
      errors.add(:cpf, 'inválido')
    end    
  end
end
