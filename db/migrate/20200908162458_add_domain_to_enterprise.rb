class AddDomainToEnterprise < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :domain, :string
  end
end
