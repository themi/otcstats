class CreateGraphs < ActiveRecord::Migration[6.1]
  def change
    create_table :graphs do |t|
      t.belongs_to :organisation, null: false, foreign_key: true
      t.string :name
      t.integer :item_number
      t.string :short_name
      t.string :defintion
      t.string :value_title
      t.string :field_titles
      t.string :envisage_key

      t.timestamps
    end
  end
end
