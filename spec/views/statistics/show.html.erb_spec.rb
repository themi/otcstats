require 'rails_helper'

RSpec.describe "statistics/show", type: :view do
  let(:org) { create(:organisation, name: "MY_ORG_NAME") }
  let(:member) { create(:member, full_name: "MY_FULL_NAME") }
  let(:graph) { create(:graph, short_name: "MY_GRAPH_NAME", field_titles: "ONE|TWO|THREE|FOUR") }

  before(:each) do
    @graph = assign(:graph, graph)
    @statistic = assign(:statistic, create(:statistic,
      organisation: org,
      graph: graph,
      added_by: member,
      value: 3,
      fact_column_1: "COLUMN_DATA1",
      fact_column_2: "COLUMN_DATA2",
      fact_column_3: "COLUMN_DATA3",
      fact_column_4: "COLUMN_DATA4"
    ))
  end

  it "renders attributes in <p>" do
    sign_in member
    render
    expect(rendered).to match(/MY_ORG_NAME/)
    expect(rendered).to match(/MY_GRAPH_NAME/)
    expect(rendered).to match(/MY_FULL_NAME/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/COLUMN_DATA1/)
    expect(rendered).to match(/COLUMN_DATA2/)
    expect(rendered).to match(/COLUMN_DATA3/)
    expect(rendered).to match(/COLUMN_DATA4/)
  end
end
