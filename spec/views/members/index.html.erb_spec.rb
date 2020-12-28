require 'rails_helper'

RSpec.describe "admin/members/index", type: :view do
  let(:org) { create(:organisation, name: "MY_ORG_NAME") }
  let(:user) {
    create(:member,
      organisation: org,
      role: "member",
      email: "email@example.com",
      full_name: "MY_FULL_NAME",
      phone: "MY_PHONE",
      address: "MY_ADDRESS",
      training_level: "MY_TRAINING_LEVEL",
      processing_level: "MY_PROCESSING_LEVEL",
      envisage_key: "MY_ENVISAGE_KEY"
    )
  }


  before(:each) do
    assign(:members, [user,
      create(:member,
        organisation: org,
        role: "member",
        email: "nomail@example.com",
        full_name: "MY_FULL_NAME",
        phone: "MY_PHONE",
        address: "MY_ADDRESS",
        training_level: "MY_TRAINING_LEVEL",
        processing_level: "MY_PROCESSING_LEVEL",
        envisage_key: "MY_ENVISAGE_KEY"
      )
    ])
  end

  it "renders a list of members" do
    sign_in user
    render
    assert_select "tr>td", text: "member", count: 2
    # assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "MY_FULL_NAME", count: 2
    assert_select "tr>td", text: "MY_PHONE", count: 2
    assert_select "tr>td", text: "MY_ADDRESS", count: 2
    assert_select "tr>td", text: "MY_TRAINING_LEVEL", count: 2
    assert_select "tr>td", text: "MY_TRAINING_LEVEL", count: 2
    assert_select "tr>td", text: "MY_ENVISAGE_KEY", count: 2
  end
end
