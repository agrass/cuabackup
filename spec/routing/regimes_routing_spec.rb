require "spec_helper"

describe RegimesController do
  describe "routing" do

    it "routes to #index" do
      get("/regimes").should route_to("regimes#index")
    end

    it "routes to #new" do
      get("/regimes/new").should route_to("regimes#new")
    end

    it "routes to #show" do
      get("/regimes/1").should route_to("regimes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/regimes/1/edit").should route_to("regimes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/regimes").should route_to("regimes#create")
    end

    it "routes to #update" do
      put("/regimes/1").should route_to("regimes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/regimes/1").should route_to("regimes#destroy", :id => "1")
    end

  end
end
