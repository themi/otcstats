require 'rails_helper'

RSpec.describe "graphs/index", type: :view do
  before(:each) do
    assign(:graphs, [
      Graph.create!(
        organisation: nil,
        name: "Name",
        item_number: 2,
        short_name: "Short Name",
        defintion: "Defintion",
        value_title: "Value Title",
        field_titles: "Field Titles",
        envisage_key: "Envisage Key"
      ),
      Graph.create!(
        organisation: nil,
        name: "Name",
        item_number: 2,
        short_name: "Short Name",
        defintion: "Defintion",
        value_title: "Value Title",
        field_titles: "Field Titles",
        envisage_key: "Envisage Key"
      )
    ])
  end

  it "renders a list of graphs" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Short Name".to_s, count: 2
    assert_select "tr>td", text: "Defintion".to_s, count: 2
    assert_select "tr>td", text: "Value Title".to_s, count: 2
    assert_select "tr>td", text: "Field Titles".to_s, count: 2
    assert_select "tr>td", text: "Envisage Key".to_s, count: 2
  end
end
