class AddEnterpriseToProfile < ActiveRecord::Migration[6.0]
  def change
    add_reference :profiles, :enterprise, null: false, foreign_key: true
  end
end
