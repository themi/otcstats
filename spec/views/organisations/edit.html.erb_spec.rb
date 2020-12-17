require 'rails_helper'

RSpec.describe "organisations/edit", type: :view do
  before(:each) do
    @organisation = assign(:organisation, Organisation.create!(
      name: "MyString",
      envisage_key: "MyString"
    ))
  end

  it "renders the edit organisation form" do
    render

    assert_select "form[action=?][method=?]", organisation_path(@organisation), "post" do

      assert_select "input[name=?]", "organisation[name]"

      assert_select "input[name=?]", "organisation[envisage_key]"
    end
  end
end
