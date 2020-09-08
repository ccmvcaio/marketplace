class RemoveRoleDepartmentCpfFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role, :string
    remove_column :users, :department, :string
    remove_column :users, :cpf, :string
  end
end
