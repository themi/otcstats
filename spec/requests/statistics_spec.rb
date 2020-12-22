 require 'rails_helper'

RSpec.describe "/statistics", type: :request do
  let(:org) { create(:organisation) }
  let(:graph) { create(:graph) }
  let(:member) { create(:member) }
  before { sign_in member }

  let(:valid_attributes) {
    build(:statistic, graph: graph, organisation: org, added_by: member).attributes
  }

  let(:invalid_attributes) {
    { value: nil, week_ending_at: nil, graph_id: graph.id }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Statistic.create! valid_attributes
      get statistics_url, params: { graph_id: graph.id }
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      statistic = Statistic.create! valid_attributes
      get statistic_url(statistic), params: { graph_id: graph.id }
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_statistic_url, params: { graph_id: graph.id }
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      statistic = Statistic.create! valid_attributes
      get edit_statistic_url(statistic), params: { graph_id: graph.id }
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Statistic" do
        expect {
          post statistics_url, params: { statistic: valid_attributes }
        }.to change(Statistic, :count).by(1)
      end

      it "redirects to the created statistic" do
        post statistics_url, params: { statistic: valid_attributes }
        expect(response).to redirect_to(new_statistic_url(graph_id: graph.id))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Statistic" do
        expect {
          post statistics_url, params: { statistic: invalid_attributes }
        }.to change(Statistic, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post statistics_url, params: { statistic: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { value: 75, graph_id: graph.id }
      }

      it "updates the requested statistic" do
        statistic = Statistic.create! valid_attributes
        patch statistic_url(statistic), params: { statistic: new_attributes }
        statistic.reload
        expect(statistic.value).to eq 75
      end

      it "redirects to the statistic" do
        statistic = Statistic.create! valid_attributes
        patch statistic_url(statistic), params: { statistic: new_attributes }
        statistic.reload
        expect(response).to redirect_to(statistics_url(graph_id: graph.id))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        statistic = Statistic.create! valid_attributes
        patch statistic_url(statistic), params: { statistic: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested statistic" do
      statistic = Statistic.create! valid_attributes
      expect {
        delete statistic_url(statistic), params: { graph_id: graph.id }
      }.to change(Statistic, :count).by(-1)
    end

    it "redirects to the statistics list" do
      statistic = Statistic.create! valid_attributes
      delete statistic_url(statistic), params: { graph_id: graph.id }
      expect(response).to redirect_to(statistics_url(graph_id: graph.id))
    end
  end
end
