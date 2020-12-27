require "rails_helper"

RSpec.describe "View Graph page", type: :system do

  let!(:graph) { create(:graph, organisation: member.organisation) }
  let!(:stats) {[
    create(:statistic, value: 10, added_by: member, graph: graph),
    create(:statistic, value: 100, graph: graph),
    create(:statistic, value: 50, graph: graph),
  ]}

  context "with a member login" do
    let!(:member) { create(:member) }

    it "see my count only" do
      sign_in member
      visit graphs_path

      expect(page).to have_selector "td", text: '10'
    end
  end

  context "with a maintainer login" do
    let!(:member) { create(:member, :maintainer) }

    it "see total count" do
      sign_in member
      visit graphs_path

      expect(page).to have_selector "td", text: '160'
    end
  end
end
