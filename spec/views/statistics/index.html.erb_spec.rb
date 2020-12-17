require 'rails_helper'

RSpec.describe "statistics/index", type: :view do
  before(:each) do
    assign(:statistics, [
      Statistic.create!(
        organisation: nil,
        graph: nil,
        added_by: 2,
        value: 3.5,
        fact_column_1: "Fact Column 1",
        fact_column_2: "Fact Column 2",
        fact_column_3: "Fact Column 3",
        fact_column_4: "Fact Column 4"
      ),
      Statistic.create!(
        organisation: nil,
        graph: nil,
        added_by: 2,
        value: 3.5,
        fact_column_1: "Fact Column 1",
        fact_column_2: "Fact Column 2",
        fact_column_3: "Fact Column 3",
        fact_column_4: "Fact Column 4"
      )
    ])
  end

  it "renders a list of statistics" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.5.to_s, count: 2
    assert_select "tr>td", text: "Fact Column 1".to_s, count: 2
    assert_select "tr>td", text: "Fact Column 2".to_s, count: 2
    assert_select "tr>td", text: "Fact Column 3".to_s, count: 2
    assert_select "tr>td", text: "Fact Column 4".to_s, count: 2
  end
end
