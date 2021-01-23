require "rails_helper"

RSpec.describe "Update Statistics", type: :system do

  let!(:member) { create(:member) }

  context "graph with value 'ea' and 3 input fields" do
    let!(:graph) { create(:graph, :each_type, organisation: member.organisation) }
    let!(:stat)  { create(:statistic, organisation: member.organisation, graph: graph, value: 1, fact_column_1: "COL_ONE" ) }

    it "Updates an existing statistic" do
      sign_in member

      visit edit_statistic_path(graph.statistics.first, graph_id: graph.id)

      fill_in "Name", with: 'COL_ONE_CHANGED'

      click_button "Save Changes"

      stat.reload
      expect(stat.fact_column_1).to eq "COL_ONE_CHANGED"
    end
  end

end
