require "rails_helper"

RSpec.describe GraphsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/graphs").to route_to("graphs#index")
    end

    it "routes to #new" do
      expect(get: "/graphs/new").to route_to("graphs#new")
    end

    it "routes to #show" do
      expect(get: "/graphs/1").to route_to("graphs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/graphs/1/edit").to route_to("graphs#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/graphs").to route_to("graphs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/graphs/1").to route_to("graphs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/graphs/1").to route_to("graphs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/graphs/1").to route_to("graphs#destroy", id: "1")
    end
  end
end
