require File.dirname(__FILE__) + '/../spec_helper'

describe AntorchasController do
  
  context "with GET index" do    
    it "should render new when no connection exists" do
      Antorcha.should_receive(:new).and_return(mock_antorcha)
      Antorcha.should_not_receive(:all)
      get :index
      response.should render_template(:index)
    end
    it "should render the first when a connection exist" do
      Antorcha.stub(:count).and_return(1)
      Antorcha.should_receive(:first).and_return(mock_antorcha)
      get :index
      response.should render_template(:index)
    end
  end
  
  
  context "with GET show and an id" do    
    it "should render the show template" do
      antorcha = mock_antorcha
      Antorcha.should_receive(:find).with(antorcha.id.to_s).and_return(antorcha)
      get :show, :id => antorcha.id
      response.should render_template(:show)
    end
  end
  
  context "with GET new" do    
    it "should render the new template" do
      Antorcha.should_receive(:new).and_return(mock_antorcha)
      get :new
      response.should render_template(:new)
    end
  end
  
  context "with GET edit and an id" do
    it "should render the edit template" do
      antorcha = mock_antorcha
      Antorcha.should_receive(:find).with(antorcha.id.to_s).and_return(antorcha)
      get :edit, :id => antorcha.id
      response.should render_template(:edit)
    end
  end

  context "with GET edit and an id" do
    it "should render the edit template" do
      antorcha = mock_antorcha
      Antorcha.should_receive(:find).with(antorcha.id.to_s).and_return(antorcha)
      get :edit, :id => antorcha.id
      response.should render_template(:edit)
    end
  end
  
  context "with DELETE destroy and an id" do
    it "should successfully destroy the antorcha with that id" do
      antorcha = mock_antorcha
      Antorcha.should_receive(:find).with(antorcha.id.to_s).and_return(antorcha)
      antorcha.stub(:destroy).and_return(antorcha)
      delete :destroy, :id => antorcha.id
      flash[:notice].should =~ /Successfully/
      Antorcha.exists?(antorcha.id).should be_false
    end
  end 
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  describe "creating an antorcha" do
    before(:each) do
      stub_new mock_antorcha
    end
  
    it "should render new template when model is invalid" do
      stub_unsuccessful_save_for mock_antorcha
      post :create
      response.should render_template(:new)
    end
  
    it "should redirect when model is valid" do
      stub_successful_save_for mock_antorcha
      post :create
      response.should redirect_to(antorchas_url)
    end
  end
  
  describe "updating an antorcha" do
    before(:each) do
      stub_find mock_antorcha
    end
    it "update action should render edit template when model is invalid" do
      stub_unsuccessful_update mock_antorcha
      put :update, :id => mock_antorcha.to_param
      response.should render_template(:edit)
    end
  
    it "update action should redirect when model is valid" do
      stub_successful_update mock_antorcha
      put :update, :id => mock_antorcha.to_param
      response.should redirect_to(antorcha_url(assigns[:antorcha]))
    end
  end  

end
