require 'rails_helper'

RSpec.describe "organisations/index", type: :view do
  let(:member) { create(:member) }
  let(:org) {
    create(:organisation, name: "MY_ORG_NAME", envisage_key: "MY_EKEY")
  }

  before(:each) do
    assign(:organisations, [
      org,
      create(:organisation, name: "MY_ORG_NAME", envisage_key: "MY_EKEY")
    ])
  end

  it "renders a list of organisations" do
    sign_in member
    render
    assert_select "tr>td", text: "MY_ORG_NAME", count: 2
    assert_select "tr>td", text: "MY_EKEY", count: 2
  end
end
