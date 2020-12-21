require 'rails_helper'

RSpec.describe "statistics/edit", type: :view do
  let(:member) { create(:member) }
  let(:graph) { create(:graph, field_titles: "ONE|TWO|THREE|FOUR") }

  before(:each) do
    @graph = assign(:graph, graph)
    @statistic = assign(:statistic, create(:statistic, graph: graph, added_by: member))
  end

  it "renders the edit statistic form" do
    sign_in member
    render

    assert_select "form[action=?][method=?]", statistic_path(@statistic), "post" do

      assert_select "input[name=?]", "statistic[organisation_id]"

      assert_select "input[name=?]", "statistic[graph_id]"

      assert_select "input[name=?]", "statistic[added_by_id]"

      assert_select "input[name=?]", "statistic[value]"

      assert_select "input[name=?]", "statistic[fact_column_1]"

      assert_select "input[name=?]", "statistic[fact_column_2]"

      assert_select "input[name=?]", "statistic[fact_column_3]"

      assert_select "input[name=?]", "statistic[fact_column_4]"
    end
  end
end
