require 'rails_helper'

RSpec.describe "organisations/edit", type: :view do
  let(:member) { create(:member) }

  before(:each) do
    @organisation = assign(:organisation, create(:organisation))
  end

  it "renders the edit organisation form" do
    sign_in member
    render

    assert_select "form[action=?][method=?]", organisation_path(@organisation), "post" do

      assert_select "input[name=?]", "organisation[name]"

      assert_select "input[name=?]", "organisation[envisage_key]"
    end
  end
end
