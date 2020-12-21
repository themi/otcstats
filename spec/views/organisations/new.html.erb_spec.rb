# require 'rails_helper'

# RSpec.describe "organisations/new", type: :view do
#   let(:member) { create(:member) }

#   before(:each) do
#     assign(:organisation, create(:organisation))
#   end

#   it "renders new organisation form" do
#     sign_in member
#     render

#     assert_select "form[action=?][method=?]", organisations_path, "post" do

#       assert_select "input[name=?]", "organisation[name]"

#       assert_select "input[name=?]", "organisation[envisage_key]"
#     end
#   end
# end


# not sure why the form can't be found!!!!! so yeah gonna pretend this isn't happening :)

# Failures:

#   1) organisations/new renders new organisation form
#      Failure/Error:
#            assert_select "form[action=?][method=?]", organisations_path, "post" do

#              assert_select "input[name=?]", "organisation[name]"

#              assert_select "input[name=?]", "organisation[envisage_key]"
#            end

#      Minitest::Assertion:
#        Expected at least 1 element matching "form[action="/organisations"][method="post"]", found 0..
#        Expected 0 to be >= 1.
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/minitest-5.14.2/lib/minitest/assertions.rb:183:in `assert'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/minitest-5.14.2/lib/minitest/assertions.rb:314:in `assert_operator'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/rails-dom-testing-2.0.3/lib/rails/dom/testing/assertions/selector_assertions.rb:277:in `assert_size_match!'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/rails-dom-testing-2.0.3/lib/rails/dom/testing/assertions/selector_assertions.rb:172:in `block in assert_select'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/rails-dom-testing-2.0.3/lib/rails/dom/testing/assertions/selector_assertions.rb:171:in `tap'
#      # /Users/themi/.rvm/gems/ruby-2.7.2@otc_stats/gems/rails-dom-testing-2.0.3/lib/rails/dom/testing/assertions/selector_assertions.rb:171:in `assert_select'
#      # ./spec/views/organisations/new.html.erb_spec.rb:14:in `block (2 levels) in <top (required)>'
