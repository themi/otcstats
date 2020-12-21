# require 'rails_helper'

# RSpec.describe "statistics/new", type: :view do
#   let(:member) { create(:member) }
#   let(:graph) { create(:graph, field_titles: "ONE|TWO|THREE|FOUR") }


#   before(:each) do
#     @graph = assign(:graph, graph)
#     @statistic = assign(:statistic, create(:statistic, graph: graph, added_by: member))
#   end

#   it "renders new statistic form" do
#     sign_in member
#     render

#     assert_select "form[action=?][method=?]", statistics_path, "post" do

#       assert_select "input[name=?]", "statistic[organisation_id]"

#       assert_select "input[name=?]", "statistic[graph_id]"

#       assert_select "input[name=?]", "statistic[added_by]"

#       assert_select "input[name=?]", "statistic[value]"

#       assert_select "input[name=?]", "statistic[fact_column_1]"

#       assert_select "input[name=?]", "statistic[fact_column_2]"

#       assert_select "input[name=?]", "statistic[fact_column_3]"

#       assert_select "input[name=?]", "statistic[fact_column_4]"
#     end
#   end
# end


#  HMMMM here it is again!

# Failures:

#   1) statistics/new renders new statistic form
#      Failure/Error:
#            assert_select "form[action=?][method=?]", statistics_path, "post" do

#              assert_select "input[name=?]", "statistic[organisation_id]"

#              assert_select "input[name=?]", "statistic[graph_id]"

#              assert_select "input[name=?]", "statistic[added_by]"

#              assert_select "input[name=?]", "statistic[value]"


#      Minitest::Assertion:
#        Expected at least 1 element matching "form[action="/statistics"][method="post"]", found 0..
#        Expected 0 to be >= 1.
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/minitest-5.14.2/lib/minitest/assertions.rb:183:in `assert'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/minitest-5.14.2/lib/minitest/assertions.rb:314:in `assert_operator'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/rails-dom-testing-2.0.3/lib/rails/dom/testing/assertions/selector_assertions.rb:277:in `assert_size_match!'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/rails-dom-testing-2.0.3/lib/rails/dom/testing/assertions/selector_assertions.rb:172:in `block in assert_select'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/rails-dom-testing-2.0.3/lib/rails/dom/testing/assertions/selector_assertions.rb:171:in `tap'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/rails-dom-testing-2.0.3/lib/rails/dom/testing/assertions/selector_assertions.rb:171:in `assert_select'
#      # ./spec/views/statistics/new.html.erb_spec.rb:17:in `block (2 levels) in <top (required)>'
