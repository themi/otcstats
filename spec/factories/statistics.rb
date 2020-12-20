# == Schema Information
#
# Table name: statistics
#
#  id              :bigint           not null, primary key
#  fact_column_1   :string
#  fact_column_2   :string
#  fact_column_3   :string
#  fact_column_4   :string
#  value           :float
#  week_ending_at  :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  added_by_id     :bigint
#  graph_id        :bigint           not null
#  organisation_id :bigint           not null
#
# Indexes
#
#  index_statistics_on_graph_id         (graph_id)
#  index_statistics_on_organisation_id  (organisation_id)
#
# Foreign Keys
#
#  fk_rails_...  (graph_id => graphs.id)
#  fk_rails_...  (organisation_id => organisations.id)
#
FactoryBot.define do
  factory :statistic do
    organisation { nil }
    graph { nil }
    added_by { 1 }
    week_ending_at { "2020-12-17 22:48:52" }
    value { 1.5 }
    fact_column_1 { "MyString" }
    fact_column_2 { "MyString" }
    fact_column_3 { "MyString" }
    fact_column_4 { "MyString" }
  end
end
