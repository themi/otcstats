class CreateOrganisations < ActiveRecord::Migration[6.1]
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :envisage_key

      t.timestamps
    end
  end
end
