 require 'rails_helper'

RSpec.describe "/graphs", type: :request do
  let(:org) { create(:organisation) }
  let(:member) { create(:member, organisation: org) }
  before { sign_in member }

  let(:valid_attributes) {
    build(:graph, organisation: org).attributes
  }

  let(:invalid_attributes) {
    { name: nil, value_title: nil, organisation: nil }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Graph.create! valid_attributes
      get graphs_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      graph = Graph.create! valid_attributes
      get graph_url(graph)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_graph_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      graph = Graph.create! valid_attributes
      get edit_graph_url(graph)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Graph" do
        expect {
          post graphs_url, params: { graph: valid_attributes }
        }.to change(Graph, :count).by(1)
      end

      it "redirects to the created graph" do
        post graphs_url, params: { graph: valid_attributes }
        expect(response).to redirect_to(graph_url(Graph.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Graph" do
        expect {
          post graphs_url, params: { graph: invalid_attributes }
        }.to change(Graph, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post graphs_url, params: { graph: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { short_name: "NEW_SHORT_NAME" }
      }

      it "updates the requested graph" do
        graph = Graph.create! valid_attributes
        patch graph_url(graph), params: { graph: new_attributes }
        graph.reload
        expect(graph.short_name).to eq "NEW_SHORT_NAME"
      end

      it "redirects to the graph" do
        graph = Graph.create! valid_attributes
        patch graph_url(graph), params: { graph: new_attributes }
        graph.reload
        expect(response).to redirect_to(graph_url(graph))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        graph = Graph.create! valid_attributes
        patch graph_url(graph), params: { graph: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested graph" do
      graph = Graph.create! valid_attributes
      expect {
        delete graph_url(graph)
      }.to change(Graph, :count).by(-1)
    end

    it "redirects to the graphs list" do
      graph = Graph.create! valid_attributes
      delete graph_url(graph)
      expect(response).to redirect_to(graphs_url)
    end
  end
end
