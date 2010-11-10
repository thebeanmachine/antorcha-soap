require File.dirname(__FILE__) + '/../spec_helper'

describe AntorchasController do
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Antorcha.first
    response.should render_template(:show)
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
      response.should redirect_to(antorcha_url(assigns[:antorcha]))
    end
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Antorcha.first
    response.should render_template(:edit)
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
  
  it "destroy action should destroy model and redirect to index action" do
    antorcha = Antorcha.first
    delete :destroy, :id => antorcha
    response.should redirect_to(antorchas_url)
    Antorcha.exists?(antorcha.id).should be_false
  end
end
