class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.decimal :price
      t.string :description
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
