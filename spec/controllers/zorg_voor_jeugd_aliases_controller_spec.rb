require 'spec_helper'

describe ZorgVoorJeugdAliasesController do

  def mock_zorg_voor_jeugd_alias(stubs={})
    @mock_zorg_voor_jeugd_alias ||= mock_model(ZorgVoorJeugdAlias, stubs)
  end

  describe "GET index" do
    it "assigns all zorg_voor_jeugd_aliases as @zorg_voor_jeugd_aliases" do
      ZorgVoorJeugdAlias.stub(:find).with(:all).and_return([mock_zorg_voor_jeugd_alias])
      get :index
      assigns[:zorg_voor_jeugd_aliases].should == [mock_zorg_voor_jeugd_alias]
    end
  end

  describe "GET show" do
    it "assigns the requested zorg_voor_jeugd_alias as @zorg_voor_jeugd_alias" do
      ZorgVoorJeugdAlias.stub(:find).with("37").and_return(mock_zorg_voor_jeugd_alias)
      get :show, :id => "37"
      assigns[:zorg_voor_jeugd_alias].should equal(mock_zorg_voor_jeugd_alias)
    end
  end

  describe "GET new" do
    it "assigns a new zorg_voor_jeugd_alias as @zorg_voor_jeugd_alias" do
      ZorgVoorJeugdAlias.stub(:new).and_return(mock_zorg_voor_jeugd_alias)
      get :new
      assigns[:zorg_voor_jeugd_alias].should equal(mock_zorg_voor_jeugd_alias)
    end
  end

  describe "GET edit" do
    it "assigns the requested zorg_voor_jeugd_alias as @zorg_voor_jeugd_alias" do
      ZorgVoorJeugdAlias.stub(:find).with("37").and_return(mock_zorg_voor_jeugd_alias)
      get :edit, :id => "37"
      assigns[:zorg_voor_jeugd_alias].should equal(mock_zorg_voor_jeugd_alias)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created zorg_voor_jeugd_alias as @zorg_voor_jeugd_alias" do
        ZorgVoorJeugdAlias.stub(:new).with({'these' => 'params'}).and_return(mock_zorg_voor_jeugd_alias(:save => true))
        post :create, :zorg_voor_jeugd_alias => {:these => 'params'}
        assigns[:zorg_voor_jeugd_alias].should equal(mock_zorg_voor_jeugd_alias)
      end

      it "redirects to the created zorg_voor_jeugd_alias" do
        ZorgVoorJeugdAlias.stub(:new).and_return(mock_zorg_voor_jeugd_alias(:save => true))
        post :create, :zorg_voor_jeugd_alias => {}
        response.should redirect_to(zorg_voor_jeugd_alias_url(mock_zorg_voor_jeugd_alias))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved zorg_voor_jeugd_alias as @zorg_voor_jeugd_alias" do
        ZorgVoorJeugdAlias.stub(:new).with({'these' => 'params'}).and_return(mock_zorg_voor_jeugd_alias(:save => false))
        post :create, :zorg_voor_jeugd_alias => {:these => 'params'}
        assigns[:zorg_voor_jeugd_alias].should equal(mock_zorg_voor_jeugd_alias)
      end

      it "re-renders the 'new' template" do
        ZorgVoorJeugdAlias.stub(:new).and_return(mock_zorg_voor_jeugd_alias(:save => false))
        post :create, :zorg_voor_jeugd_alias => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested zorg_voor_jeugd_alias" do
        ZorgVoorJeugdAlias.should_receive(:find).with("37").and_return(mock_zorg_voor_jeugd_alias)
        mock_zorg_voor_jeugd_alias.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :zorg_voor_jeugd_alias => {:these => 'params'}
      end

      it "assigns the requested zorg_voor_jeugd_alias as @zorg_voor_jeugd_alias" do
        ZorgVoorJeugdAlias.stub(:find).and_return(mock_zorg_voor_jeugd_alias(:update_attributes => true))
        put :update, :id => "1"
        assigns[:zorg_voor_jeugd_alias].should equal(mock_zorg_voor_jeugd_alias)
      end

      it "redirects to the zorg_voor_jeugd_alias" do
        ZorgVoorJeugdAlias.stub(:find).and_return(mock_zorg_voor_jeugd_alias(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(zorg_voor_jeugd_alias_url(mock_zorg_voor_jeugd_alias))
      end
    end

    describe "with invalid params" do
      it "updates the requested zorg_voor_jeugd_alias" do
        ZorgVoorJeugdAlias.should_receive(:find).with("37").and_return(mock_zorg_voor_jeugd_alias)
        mock_zorg_voor_jeugd_alias.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :zorg_voor_jeugd_alias => {:these => 'params'}
      end

      it "assigns the zorg_voor_jeugd_alias as @zorg_voor_jeugd_alias" do
        ZorgVoorJeugdAlias.stub(:find).and_return(mock_zorg_voor_jeugd_alias(:update_attributes => false))
        put :update, :id => "1"
        assigns[:zorg_voor_jeugd_alias].should equal(mock_zorg_voor_jeugd_alias)
      end

      it "re-renders the 'edit' template" do
        ZorgVoorJeugdAlias.stub(:find).and_return(mock_zorg_voor_jeugd_alias(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested zorg_voor_jeugd_alias" do
      ZorgVoorJeugdAlias.should_receive(:find).with("37").and_return(mock_zorg_voor_jeugd_alias)
      mock_zorg_voor_jeugd_alias.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the zorg_voor_jeugd_aliases list" do
      ZorgVoorJeugdAlias.stub(:find).and_return(mock_zorg_voor_jeugd_alias(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(zorg_voor_jeugd_aliases_url)
    end
  end

end
