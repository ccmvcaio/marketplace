class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :enterprise
  has_many :products

  validates :full_name, :social_name, :cpf, :birth_date,
            :department, :role, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_must_be_valid

  private

  def cpf_must_be_valid
    if cpf.present? && !CPF.valid?(cpf, strict: true)
      errors.add(:cpf, 'inválido')
    end    
  end
end
