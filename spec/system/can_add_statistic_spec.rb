require "rails_helper"

RSpec.describe "Maintain Statistics", type: :system do

  let!(:member) { create(:member) }
  let!(:graph)  { create(:graph, organisation: member.organisation) }

  context "graph with value 'ea' and 3 input fields" do
    let!(:graph)  { create(:graph, organisation: member.organisation) }

    it "add a new statistic is added" do
      sign_in member
      visit new_statistic_path(graph_id: graph.id)

      fill_in "COL1", with: 'COL_ONE'
      fill_in "COL2", with: 'COL_TWO'
      fill_in "COL3", with: 'COL_THREE'
      click_button "Create Statistic"

      click_link "Done"

      expect(page).to have_selector "td", text: "1"
      expect(page).to have_selector "td", text: "COL_ONE"
      expect(page).to have_selector "td", text: "COL_TWO"
      expect(page).to have_selector "td", text: "COL_THREE"
    end
  end

  context "graph with value 'Total' and 2 input fields" do
    let!(:graph)  { create(:graph, organisation: member.organisation, value_title: "Total", field_titles: "COL1|COL2") }

    it "add a new statistic total" do
      sign_in member
      visit new_statistic_path(graph_id: graph.id)

      fill_in "Total", with: '100'
      fill_in "COL1", with: 'COL_ONE'
      fill_in "COL2", with: 'COL_TWO'
      click_button "Create Statistic"

      click_link "Done"

      expect(page).to have_selector "td", text: "100"
      expect(page).to have_selector "td", text: "COL_ONE"
      expect(page).to have_selector "td", text: "COL_TWO"
    end
  end

  context "graph with value 'ea' and Org field" do
    let!(:orgs) {[
      create(:organisation, name: "ORG1", continent: "CONT"),
      create(:organisation, name: "ORG2", continent: "CONT"),
    ]}
    let!(:graph)  { create(:graph, organisation: member.organisation, field_titles: "Org") }

    it "add a new statistic with selected organisation" do
      sign_in member
      visit new_statistic_path(graph_id: graph.id)

      select 'ORG2', from: 'Org'
      click_button "Create Statistic"

      click_link "Done"

      expect(page).to have_selector "td", text: "1"
      expect(page).to have_selector "td", text: "ORG2"
    end
  end

  context "graph with value 'ea' and Org field" do
    let!(:members) {[
      create(:member, full_name: "JOJO", organisation: member.organisation ),
      create(:member, full_name: "MARY", organisation: member.organisation ),
    ]}
    let!(:graph)  { create(:graph, organisation: member.organisation, field_titles: "OTC Member") }

    it "add a new statistic with selected member" do
      sign_in member
      visit new_statistic_path(graph_id: graph.id)

      fill_in "OTC Member", with: 'JOJO'
      click_button "Create Statistic"

      click_link "Done"

      expect(page).to have_selector "td", text: "1"
      expect(page).to have_selector "td", text: "JOJO"
    end
  end

end
