class AddEmailDomainToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email_domain, :string
  end
end
