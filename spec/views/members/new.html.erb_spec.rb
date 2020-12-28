require 'rails_helper'

RSpec.describe "admin/members/new", type: :view do
  let(:user) { create(:member) }

  before(:each) do
    assign(:member, build(:member))
  end

  it "renders new member form" do
    sign_in user
    render

    assert_select "form[action=?][method=?]", admin_members_path, "post" do

      assert_select "select[name=?]", "member[organisation_id]"

      assert_select "input[name=?]", "member[role]"

      assert_select "input[name=?]", "member[full_name]"

      assert_select "input[name=?]", "member[email]"

      assert_select "input[name=?]", "member[phone]"

      assert_select "input[name=?]", "member[address]"

      assert_select "input[name=?]", "member[training_level]"

      assert_select "input[name=?]", "member[processing_level]"

      assert_select "input[name=?]", "member[envisage_key]"
    end
  end
end
