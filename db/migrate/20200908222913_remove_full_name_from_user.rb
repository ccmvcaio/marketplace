class RemoveFullNameFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :full_name, :string
  end
end
