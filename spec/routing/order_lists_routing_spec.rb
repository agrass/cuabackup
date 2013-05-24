require "spec_helper"

describe OrderListsController do
  describe "routing" do

    it "routes to #index" do
      get("/order_lists").should route_to("order_lists#index")
    end

    it "routes to #new" do
      get("/order_lists/new").should route_to("order_lists#new")
    end

    it "routes to #show" do
      get("/order_lists/1").should route_to("order_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/order_lists/1/edit").should route_to("order_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/order_lists").should route_to("order_lists#create")
    end

    it "routes to #update" do
      put("/order_lists/1").should route_to("order_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/order_lists/1").should route_to("order_lists#destroy", :id => "1")
    end

  end
end
