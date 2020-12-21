require 'rails_helper'

RSpec.describe "statistics/index", type: :view do
  let(:org) { create(:organisation, name: "MY_ORG_NAME") }
  let(:member) { create(:member, full_name: "MY_FULL_NAME") }
  let(:graph) { create(:graph, short_name: "MY_GRAPH_NAME", field_titles: "ONE|TWO|THREE|FOUR") }

  before(:each) do
    @graph = assign(:graph, graph)
    assign(:statistics, [
      create(:statistic,
        organisation: org,
        graph: graph,
        added_by: member,
        value: 3,
        fact_column_1: "COLUMN_DATA1",
        fact_column_2: "COLUMN_DATA2",
        fact_column_3: "COLUMN_DATA3",
        fact_column_4: "COLUMN_DATA4"
      ),
      create(:statistic,
        organisation: org,
        graph: graph,
        added_by: member,
        value: 3,
        fact_column_1: "COLUMN_DATA1",
        fact_column_2: "COLUMN_DATA2",
        fact_column_3: "COLUMN_DATA3",
        fact_column_4: "COLUMN_DATA4"
      )
    ])
  end

  it "renders a list of statistics" do
    sign_in member
    render
    # assert_select "tr>td", text: nil.to_s, count: 2
    # assert_select "tr>td", text: nil.to_s, count: 2
    # assert_select "tr>td", text: 2.to_s, count: 2

    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "COLUMN_DATA1", count: 2
    assert_select "tr>td", text: "COLUMN_DATA2", count: 2
    assert_select "tr>td", text: "COLUMN_DATA3", count: 2
    assert_select "tr>td", text: "COLUMN_DATA4", count: 2
  end
end
