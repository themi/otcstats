require 'rails_helper'

RSpec.describe "members/show", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      organisation: nil,
      role: 2,
      full_name: "Full Name",
      phone: "Phone",
      address: "Address",
      training_level: "Training Level",
      processing_level: "Processing Level",
      envisage_key: "Envisage Key"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Full Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Training Level/)
    expect(rendered).to match(/Processing Level/)
    expect(rendered).to match(/Envisage Key/)
  end
end
