class CreateStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :statistics do |t|
      t.belongs_to :organisation, null: false, foreign_key: true
      t.belongs_to :graph, null: false, foreign_key: true
      t.integer :added_by
      t.datetime :week_ending_at
      t.float :value
      t.string :fact_column_1
      t.string :fact_column_2
      t.string :fact_column_3
      t.string :fact_column_4

      t.timestamps
    end
  end
end
