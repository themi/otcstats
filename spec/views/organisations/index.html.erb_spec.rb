require 'rails_helper'

RSpec.describe "organisations/index", type: :view do
  before(:each) do
    assign(:organisations, [
      Organisation.create!(
        name: "Name",
        envisage_key: "Envisage Key"
      ),
      Organisation.create!(
        name: "Name",
        envisage_key: "Envisage Key"
      )
    ])
  end

  it "renders a list of organisations" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Envisage Key".to_s, count: 2
  end
end
