require 'rails_helper'

RSpec.describe "admin/members/show", type: :view do
  let(:user) {
    create(:member,
      organisation: create(:organisation, name: "MY_ORG_NAME"),
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
    @member = assign(:member, user)
  end

  it "renders attributes in <p>" do
    sign_in user
    render
    expect(rendered).to match(/MY_ORG_NAME/)
    expect(rendered).to match(/member/)
    expect(rendered).to match(/MY_FULL_NAME/)
    expect(rendered).to match(/email@example.com/)
    expect(rendered).to match(/MY_PHONE/)
    expect(rendered).to match(/MY_ADDRESS/)
    expect(rendered).to match(/MY_TRAINING_LEVEL/)
    expect(rendered).to match(/MY_PROCESSING_LEVEL/)
    expect(rendered).to match(/MY_ENVISAGE_KEY/)
  end
end
