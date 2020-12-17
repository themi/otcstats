require 'rails_helper'

RSpec.describe "statistics/new", type: :view do
  before(:each) do
    assign(:statistic, Statistic.new(
      organisation: nil,
      graph: nil,
      added_by: 1,
      value: 1.5,
      fact_column_1: "MyString",
      fact_column_2: "MyString",
      fact_column_3: "MyString",
      fact_column_4: "MyString"
    ))
  end

  it "renders new statistic form" do
    render

    assert_select "form[action=?][method=?]", statistics_path, "post" do

      assert_select "input[name=?]", "statistic[organisation_id]"

      assert_select "input[name=?]", "statistic[graph_id]"

      assert_select "input[name=?]", "statistic[added_by]"

      assert_select "input[name=?]", "statistic[value]"

      assert_select "input[name=?]", "statistic[fact_column_1]"

      assert_select "input[name=?]", "statistic[fact_column_2]"

      assert_select "input[name=?]", "statistic[fact_column_3]"

      assert_select "input[name=?]", "statistic[fact_column_4]"
    end
  end
end
