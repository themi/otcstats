require 'rails_helper'

RSpec.describe "graphs/show", type: :view do
  before(:each) do
    @graph = assign(:graph, Graph.create!(
      organisation: nil,
      name: "Name",
      item_number: 2,
      short_name: "Short Name",
      defintion: "Defintion",
      value_title: "Value Title",
      field_titles: "Field Titles",
      envisage_key: "Envisage Key"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Short Name/)
    expect(rendered).to match(/Defintion/)
    expect(rendered).to match(/Value Title/)
    expect(rendered).to match(/Field Titles/)
    expect(rendered).to match(/Envisage Key/)
  end
end
