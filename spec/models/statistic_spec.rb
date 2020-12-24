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
#  original_value  :string
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
require 'rails_helper'

RSpec.describe Statistic, type: :model do
  let(:eow)    { Time.current.production_end_of_week }
  let(:graph) { create(:graph) }
  let(:member1) { create(:member) }
  let(:member2) { create(:member) }
  let!(:stats)   {
    [create(:statistic, organisation: member1.organisation, graph: graph, added_by: member1, week_ending_at: eow, value: 1),
    create(:statistic, organisation: member1.organisation, graph: graph, added_by: member1, week_ending_at: eow, value: 1),
    create(:statistic, organisation: member2.organisation, graph: graph, added_by: member2, week_ending_at: eow, value: 1)]
  }

  it "to_s returns short name" do
    expect(stats[0].to_s).to eq stats[0].graph.short_name
  end

  context "#my_total_stats" do
    subject(:action) { described_class.my_total_stats(eow, graph_id, member_id) }
    let(:graph_id) { graph.id }
    context "with multiple stats" do
      let(:member_id) { member1.id }

      it "member1 stats == 2" do
        expect(action).to eq 2
      end
    end
    context "with single stat" do
      let(:member_id) { member2.id }

      it "member1 stats == 1" do
        expect(action).to eq 1
      end
    end
  end

  context "#total_stats" do
    subject(:action) { described_class.total_stats(eow, graph_id) }
    let(:graph_id) { graph.id }
    it "total stats == 3" do
      expect(action).to eq 3
    end
  end

end
