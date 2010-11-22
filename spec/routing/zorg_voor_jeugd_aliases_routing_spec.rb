require 'spec_helper'

describe ZorgVoorJeugdAliasesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/zorg_voor_jeugd_aliases" }.should route_to(:controller => "zorg_voor_jeugd_aliases", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/zorg_voor_jeugd_aliases/new" }.should route_to(:controller => "zorg_voor_jeugd_aliases", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/zorg_voor_jeugd_aliases/1" }.should route_to(:controller => "zorg_voor_jeugd_aliases", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/zorg_voor_jeugd_aliases/1/edit" }.should route_to(:controller => "zorg_voor_jeugd_aliases", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/zorg_voor_jeugd_aliases" }.should route_to(:controller => "zorg_voor_jeugd_aliases", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/zorg_voor_jeugd_aliases/1" }.should route_to(:controller => "zorg_voor_jeugd_aliases", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/zorg_voor_jeugd_aliases/1" }.should route_to(:controller => "zorg_voor_jeugd_aliases", :action => "destroy", :id => "1") 
    end
  end
end
