require 'rails_helper'

RSpec.describe "statistics/show", type: :view do
  before(:each) do
    @statistic = assign(:statistic, Statistic.create!(
      organisation: nil,
      graph: nil,
      added_by: 2,
      value: 3.5,
      fact_column_1: "Fact Column 1",
      fact_column_2: "Fact Column 2",
      fact_column_3: "Fact Column 3",
      fact_column_4: "Fact Column 4"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Fact Column 1/)
    expect(rendered).to match(/Fact Column 2/)
    expect(rendered).to match(/Fact Column 3/)
    expect(rendered).to match(/Fact Column 4/)
  end
end
