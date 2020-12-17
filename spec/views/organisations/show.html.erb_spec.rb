require 'rails_helper'

RSpec.describe "organisations/show", type: :view do
  before(:each) do
    @organisation = assign(:organisation, Organisation.create!(
      name: "Name",
      envisage_key: "Envisage Key"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Envisage Key/)
  end
end
