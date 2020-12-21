require 'rails_helper'

RSpec.describe "graphs/show", type: :view do
  let(:member) { create(:member) }

  before(:each) do
    @graph = assign(:graph, create(:graph,
      organisation: create(:organisation, name: "ORG_NAME"),
      name: "GRAPH_NAME",
      item_number: 1,
      short_name: "GRAPH_SHORT_NAME",
      definition: "GRAPH_DEFINITION",
      value_title: "GRAPH_VALUE_TITLE",
      field_titles: "GRAPH_COLUMN1",
      envisage_key: "GRAPH_EKEY"
    ))
  end

  it "renders attributes in <p>" do
    sign_in member
    render
    expect(rendered).to match(/ORG_NAME/)
    expect(rendered).to match(/GRAPH_NAME/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/GRAPH_SHORT_NAME/)
    expect(rendered).to match(/GRAPH_DEFINITION/)
    expect(rendered).to match(/GRAPH_VALUE_TITLE/)
    expect(rendered).to match(/GRAPH_COLUMN1/)
    expect(rendered).to match(/GRAPH_EKEY/)
  end
end
