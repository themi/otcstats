require "rails_helper"

RSpec.describe "Landing Page", type: :system do

  context "with no login" do
    it "be directed to the landing page" do
      visit root_path

      expect(page).to have_css "h1", text: "Purpose"
    end

    it "where you can login..." do
      visit root_path
      click_link "Log in"
      expect(page).to have_css "h2", text: "Log in"
    end

  end
end
