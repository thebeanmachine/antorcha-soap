require 'spec_helper'

describe OperationsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/operations" }.should route_to(:controller => "operations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/operations/new" }.should route_to(:controller => "operations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/operations/1" }.should route_to(:controller => "operations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/operations/1/edit" }.should route_to(:controller => "operations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/operations" }.should route_to(:controller => "operations", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/operations/1" }.should route_to(:controller => "operations", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/operations/1" }.should route_to(:controller => "operations", :action => "destroy", :id => "1") 
    end
  end
end
