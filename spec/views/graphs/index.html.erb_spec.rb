require 'rails_helper'

RSpec.describe "graphs/index", type: :view do
  let(:member) { create(:member) }
  let(:org) { create(:organisation, name: "ORG_NAME") }

  before(:each) do
    assign(:graphs, [
      create(:graph,
        organisation: org,
        name: "GRAPH_NAME",
        item_number: 1,
        short_name: "GRAPH_SHORT_NAME",
        definition: "GRAPH_DEFINITION",
        value_title: "GRAPH_VALUE_TITLE",
        field_titles: "GRAPH_COLUMN",
        envisage_key: "GRAPH_EKEY"
      ),
      create(:graph,
        organisation: org,
        name: "GRAPH_NAME",
        item_number: 2,
        short_name: "GRAPH_SHORT_NAME",
        definition: "GRAPH_DEFINITION",
        value_title: "GRAPH_VALUE_TITLE",
        field_titles: "GRAPH_COLUMN",
        envisage_key: "GRAPH_EKEY"
      )
    ])
  end

  it "renders a list of graphs" do
    sign_in member
    render
    assert_select "tr>td", text: "ORG_NAME", count: 2
    assert_select "tr>td", text: "GRAPH_NAME", count: 2
    # assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "GRAPH_SHORT_NAME", count: 2
    assert_select "tr>td", text: "GRAPH_DEFINITION", count: 2
    # removed from the list view
    # ----------
    # assert_select "tr>td", text: "GRAPH_VALUE_TITLE", count: 2
    # assert_select "tr>td", text: "GRAPH_COLUMN", count: 2
    # assert_select "tr>td", text: "GRAPH_EKEY", count: 2
  end
end
