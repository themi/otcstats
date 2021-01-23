# == Schema Information
#
# Table name: graphs
#
#  id              :bigint           not null, primary key
#  active_state    :integer          default("normal"), not null
#  definition      :string
#  envisage_key    :string
#  envisage_name   :string
#  field_titles    :string
#  item_number     :integer
#  name            :string
#  short_name      :string
#  value_title     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organisation_id :bigint           not null
#
# Indexes
#
#  index_graphs_on_organisation_id  (organisation_id)
#
# Foreign Keys
#
#  fk_rails_...  (organisation_id => organisations.id)
#
FactoryBot.define do
  factory :graph do
    organisation
    name                    { FFaker::Lorem.words.join(" ") }
    sequence(:item_number)  { |n| n }
    short_name              { FFaker::Lorem.word }
    definition              { FFaker::Lorem.sentence }
    value_title             { "ea" }
    field_titles            { "COL1|COL2|COL3" }

    trait :each_type do
      value_title  { "ea" }
      field_titles { "Name|Project|Member" }
    end
  end

end
