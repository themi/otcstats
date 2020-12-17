require 'rails_helper'

RSpec.describe "members/index", type: :view do
  before(:each) do
    assign(:members, [
      Member.create!(
        organisation: nil,
        full_name: "Full Name",
        phone: "Phone",
        address: "Address",
        training_level: "Training Level",
        processing_level: "Processing Level",
        envisage_key: "Envisage Key"
      ),
      Member.create!(
        organisation: nil,
        full_name: "Full Name",
        phone: "Phone",
        address: "Address",
        training_level: "Training Level",
        processing_level: "Processing Level",
        envisage_key: "Envisage Key"
      )
    ])
  end

  it "renders a list of members" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Full Name".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
    assert_select "tr>td", text: "Address".to_s, count: 2
    assert_select "tr>td", text: "Training Level".to_s, count: 2
    assert_select "tr>td", text: "Processing Level".to_s, count: 2
    assert_select "tr>td", text: "Envisage Key".to_s, count: 2
  end
end
