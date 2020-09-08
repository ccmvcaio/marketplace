class CreateEnterprises < ActiveRecord::Migration[6.0]
  def change
    create_table :enterprises do |t|
      t.string :name
      t.string :cnpj
      t.string :email
      t.string :country
      t.string :state
      t.string :address

      t.timestamps
    end
  end
end
