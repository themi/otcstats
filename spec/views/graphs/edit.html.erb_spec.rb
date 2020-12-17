require 'rails_helper'

RSpec.describe "graphs/edit", type: :view do
  before(:each) do
    @graph = assign(:graph, Graph.create!(
      organisation: nil,
      name: "MyString",
      item_number: 1,
      short_name: "MyString",
      defintion: "MyString",
      value_title: "MyString",
      field_titles: "MyString",
      envisage_key: "MyString"
    ))
  end

  it "renders the edit graph form" do
    render

    assert_select "form[action=?][method=?]", graph_path(@graph), "post" do

      assert_select "input[name=?]", "graph[organisation_id]"

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
