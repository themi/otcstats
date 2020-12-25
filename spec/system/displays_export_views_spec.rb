require "rails_helper"

RSpec.describe "Export and Compliance Report", type: :system do

  context "with a maintanier and a member" do
    let(:org) { create(:organisation) }
    let(:members) {[
      create(:member, role: "maintainer", organisation: org),
      create(:member, organisation: org),
    ]}

    it "a maintainer can view the report" do
      sign_in members[0]
      visit report_graphs_path
      expect(page).to have_content "OT Committee Statistics"
    end

    it "a member cannot see the stats i/c menu" do
      sign_in members[1]
      visit root_path
      expect(page).to_not have_content "Stats I/C Menu"
    end

    it "a maintainer can view the csv export" do
      sign_in members[0]
      visit csv_graphs_path
      expect(page).to have_content "Graph ID,Graph Name,"
    end
  end

end
