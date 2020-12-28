# OTC Stats Capture

This web app is for data entry of OT Committee statistics.  It produces the weekly Compilance Report for uplines and also a csv styled export for uploading raw data to `envisage.io`.

Members are imported from Envisage and thus maintaned by Envisage.  Though a login is made avaible so that all members can enter their own stats, this app can be soley maintained by the Stats I/C as needed.

Before the Compliance/CSV report are displayed the following is done:

* latest AU/US exchange rate retreived from `rba.gov.au`
* stats with funds tagged with AU dollars are then gathered and converted to US
* original value is preserved


## Developer setup

### Pre-requists

* Ruby 2.7
* Postgres (configurable to MySQL, SQLite if needed)
* Imagemagick

### 3rd party libraries/interfaces

* Rails 6.0.2 (Gemfile)
* Devise 4.7.3 (Gemfile)
* Bootstrap 4 (installed via yarn/webpacker)
* Bootstrap-Icons has been downloaded and installed into the assets folders
* Envisage interface is custom built and located in `app/services`
* AU/US ExchangeRate interface is a custom built RSS feed from rba.gov.au located in `app/services`

### Data setup

The following files located in the `config` folder are needed to initialise the db:

```
organisation.csv
members.csv
otc_graphs.yml
```

setup with:

```
bundle exec rake db:create db:migrate
bundle exec rake dbmaint:load_org
bundle exec rake dbmaint:load_members
bundle exec rake dbmaint:otc_graphs
```

NOTE: `dbmaint:load_members` also initalises each password and displays to you. No need to keep updating via this means as subsequently that can be done in-app.



### tests

```
bundle exec rake (or bundle exec rspec)
```


## Build Notes

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

rails g scaffold Statistic organisation:belongs_to graph:belongs_to added_by:integer week_ending_at:datetime value:float currency fact_column_1 fact_column_2 fact_column_3 fact_column_4, original_value

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
t.string     :original_value
```

