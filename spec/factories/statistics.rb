# == Schema Information
#
# Table name: statistics
#
#  id              :bigint           not null, primary key
#  currency        :string
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
#  index_statistics_on_added_by_id      (added_by_id)
#  index_statistics_on_graph_id         (graph_id)
#  index_statistics_on_organisation_id  (organisation_id)
#  index_statistics_on_week_ending_at   (week_ending_at)
#
# Foreign Keys
#
#  fk_rails_...  (graph_id => graphs.id)
#  fk_rails_...  (organisation_id => organisations.id)
#
FactoryBot.define do
  factory :statistic do
    organisation
    graph
    added_by       { create(:member) }
    week_ending_at { "2020-12-17" }
    value          { 1 }
    fact_column_1  { "COL1" }
    fact_column_2  { "COL2" }
    fact_column_3  { "COL3" }
    fact_column_4  { "COL4" }
  end
end
