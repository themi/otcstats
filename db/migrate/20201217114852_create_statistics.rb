class CreateStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :statistics do |t|
      t.belongs_to :organisation, null: false, foreign_key: true
      t.belongs_to :graph, null: false, foreign_key: true
      t.bigint :added_by_id, index: true
      t.date :week_ending_at, index: true
      t.float :value
      t.string :currency
      t.string :fact_column_1
      t.string :fact_column_2
      t.string :fact_column_3
      t.string :fact_column_4

      t.timestamps
    end
  end
end
