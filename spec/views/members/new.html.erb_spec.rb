require 'rails_helper'

RSpec.describe "members/new", type: :view do
  before(:each) do
    assign(:member, Member.new(
      organisation: nil,
      full_name: "MyString",
      phone: "MyString",
      address: "MyString",
      training_level: "MyString",
      processing_level: "MyString",
      envisage_key: "MyString"
    ))
  end

  it "renders new member form" do
    render

    assert_select "form[action=?][method=?]", members_path, "post" do

      assert_select "input[name=?]", "member[organisation_id]"

      assert_select "input[name=?]", "member[full_name]"

      assert_select "input[name=?]", "member[phone]"

      assert_select "input[name=?]", "member[address]"

      assert_select "input[name=?]", "member[training_level]"

      assert_select "input[name=?]", "member[processing_level]"

      assert_select "input[name=?]", "member[envisage_key]"
    end
  end
end
