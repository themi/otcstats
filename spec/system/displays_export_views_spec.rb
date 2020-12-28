require "rails_helper"

RSpec.describe "Export and Compliance Report", type: :system do

  context "with a maintanier and a member" do
    let(:org) { create(:organisation) }
    let(:maintainer) { create(:member, role: "maintainer", organisation: org) }
    let(:member) { create(:member, organisation: org) }

    it "a maintainer can view the report" do
      sign_in maintainer
      visit report_graphs_path
      expect(page).to have_content "OT Committee Statistics"
    end

    it "a member cannot see the stats i/c menu" do
      sign_in member
      visit root_path
      expect(page).to_not have_content "Stats I/C Menu"
    end

    context "with graphs and stats" do
      let!(:graph) { create(:graph, organisation: org, envisage_name: "SOME STUFF") }
      let!(:stats) {[
        create(:statistic, graph: graph),
        create(:statistic, graph: graph),
      ]}

      it "csv export has details" do
        sign_in maintainer
        visit csv_graphs_path
        expect(page).to have_content "SOME STUFF"
      end
    end
  end
end
