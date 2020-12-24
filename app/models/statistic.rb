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
class Statistic < ApplicationRecord
  belongs_to :organisation
  belongs_to :graph
  belongs_to :added_by, class_name: "Member"

  scope :my_recent, ->(eow, graph_id, member_id) {
    where(graph_id: graph_id).
    where(added_by_id: member_id).
    where(week_ending_at: eow)
  }

  scope :recent, ->(eow, graph_id) {
    where(graph_id: graph_id).
    where(week_ending_at: eow)
  }

  class << self
    def total_stats(eow, graph_id)
      self.recent(eow, graph_id).sum(:value)
    end

    def my_total_stats(eow, graph_id, member_id)
      self.my_recent(eow, graph_id, member_id).sum(:value)
    end
  end

  validates :value, :week_ending_at, presence: true


  def to_s
    self.graph.to_s
  end

  def value_title
    self.graph.value_title
  end

  def field_titles_array
    self.graph.field_titles_array
  end

  def get_field_title_for(index)
    self.graph.get_field_title_for(index)
  end

end
