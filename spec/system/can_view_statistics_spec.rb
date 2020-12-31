require "rails_helper"

RSpec.describe "View Statistics page", type: :system do

  let!(:graph) { create(:graph, organisation: member.organisation) }
  let!(:stats) {[
    create(:statistic, value: 10, added_by: member, graph: graph),
    create(:statistic, value: 100, graph: graph),
    create(:statistic, value: 50, graph: graph),
  ]}

  context "with a member login" do
    let!(:member) { create(:member) }

    it "see my stat only" do
      sign_in member
      visit statistics_path(graph_id: graph.id)

      expect(page).to have_selector "td", text: Time.current_eow.strftime("%-d\/%-m\/%Y"), count: 1
    end
  end

  context "with a maintainer login" do
    let!(:member) { create(:member, :maintainer) }

    it "see all stats" do
      sign_in member
      visit statistics_path(graph_id: graph.id)

      expect(page).to have_selector "td", text: Time.current_eow.strftime("%-d\/%-m\/%Y"), count: 3
    end
  end
end
