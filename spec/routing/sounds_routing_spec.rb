require "spec_helper"

describe SoundsController do
  describe "routing" do

    it "routes to #index" do
      get("/sounds").should route_to("sounds#index")
    end

    it "routes to #new" do
      get("/sounds/new").should route_to("sounds#new")
    end

    it "routes to #show" do
      get("/sounds/1").should route_to("sounds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sounds/1/edit").should route_to("sounds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sounds").should route_to("sounds#create")
    end

    it "routes to #update" do
      put("/sounds/1").should route_to("sounds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sounds/1").should route_to("sounds#destroy", :id => "1")
    end

  end
end
