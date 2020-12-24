# OTC Stats Capture

## Implementation Notes

* Install bootstrap4
  - https://www.mashrurhossain.com/blog/rails6bootstrap4

## Structure

* Org

```
rails destroy scaffold Organisation

rails g scaffold Organisation name envisage_key

t.string :name
t.string :envisage_key
```

* members:

```
rails destroy scaffold Member

rails g scaffold Member organisation:belongs_to role:integer full_name phone address training_level processing_level envisage_key

rails g devise Member

# then add these
t.belongs_to :organisation
t.integer    :role, null: false, default: 0
t.string     :full_name
t.string     :phone
t.string     :address
t.string     :training_level
t.string     :processing_level
t.string     :envisage_key
```

* graphs:

```
rails destroy scaffold Graph

rails g scaffold Graph organisation:belongs_to name item_number:integer short_name definition value_title field_titles envisage_key active_state:integer

t.belongs_to :organisation
t.string :name
t.integer :item_number
t.string :short_name
t.string :definition
t.string :value_title
t.string :field_titles
t.string :envisage_key
t.integer :active_state, null: false, default: 0
```

* statistics:

```
rails destroy scaffold Statistic

rails g scaffold Statistic organisation:belongs_to graph:belongs_to added_by:integer week_ending_at:datetime value:float currency fact_column_1 fact_column_2 fact_column_3 fact_column_4

t.belongs_to :organisation
t.belongs_to :graph
t.integer    :added_by
t.datetime   :week_ending_at
t.float      :value
t.string     :currency
t.string     :fact_column_1
t.string     :fact_column_2
t.string     :fact_column_3
t.string     :fact_column_4
```
