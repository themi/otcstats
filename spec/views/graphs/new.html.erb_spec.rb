require 'rails_helper'

RSpec.describe "graphs/new", type: :view do
  let(:member) { create(:member) }

  before(:each) do
    assign(:graph, build(:graph))
  end

  it "renders new graph form" do
    sign_in member
    render

    assert_select "form[action=?][method=?]", graphs_path, "post" do

      assert_select "select[name=?]", "graph[organisation_id]"

      assert_select "input[name=?]", "graph[name]"

      assert_select "input[name=?]", "graph[item_number]"

      assert_select "input[name=?]", "graph[short_name]"

      assert_select "input[name=?]", "graph[defintion]"

      assert_select "input[name=?]", "graph[value_title]"

      assert_select "input[name=?]", "graph[field_titles]"

      assert_select "input[name=?]", "graph[envisage_key]"
    end
  end
end
