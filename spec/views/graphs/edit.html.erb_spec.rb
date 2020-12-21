require 'rails_helper'

RSpec.describe "graphs/edit", type: :view do
  let(:member) { create(:member) }

  before(:each) do
    @graph = assign(:graph, create(:graph))
  end

  it "renders the edit graph form" do
    sign_in member
    render

    assert_select "form[action=?][method=?]", graph_path(@graph), "post" do

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
