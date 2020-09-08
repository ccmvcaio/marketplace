class RemoveSocialNameAndDateOfBirthFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :social_name, :string
    remove_column :users, :date_of_birth, :date
  end
end
