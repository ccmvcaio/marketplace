class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :social_name
      t.string :cpf
      t.date :birth_date
      t.string :role
      t.string :department
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
