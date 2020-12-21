require 'rails_helper'

RSpec.describe "organisations/show", type: :view do
  let(:member) { create(:member) }
  let(:org) {
    create(:organisation, name: "MY_ORG_NAME", envisage_key: "MY_EKEY")
  }

  before(:each) do
    @organisation = assign(:organisation, org)
  end

  it "renders attributes in <p>" do
    sign_in member
    render
    expect(rendered).to match(/MY_ORG_NAME/)
    expect(rendered).to match(/MY_EKEY/)
  end
end
