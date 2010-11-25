require 'spec_helper'

describe OperationsController do

  def mock_operation(stubs={})
    @mock_operation ||= mock_model(Operation, stubs)
  end

  describe "GET index" do
    it "assigns all operations as @operations" do
      Operation.stub(:find).with(:all, :order=>"updated_at desc", :limit=>100).and_return([mock_operation])
      get :index
      assigns[:operations].should == [mock_operation]
    end
  end

  describe "GET show" do
    it "assigns the requested operation as @operation" do
      Operation.stub(:find).with("37").and_return(mock_operation)
      get :show, :id => "37"
      assigns[:operation].should equal(mock_operation)
    end
  end

  describe "GET new" do
    it "assigns a new operation as @operation" do
      Operation.stub(:new).and_return(mock_operation)
      get :new
      assigns[:operation].should equal(mock_operation)
    end
  end

  describe "GET edit" do
    it "assigns the requested operation as @operation" do
      Operation.stub(:find).with("37").and_return(mock_operation)
      get :edit, :id => "37"
      assigns[:operation].should equal(mock_operation)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created operation as @operation" do
        Operation.stub(:new).with({'these' => 'params'}).and_return(mock_operation(:save => true))
        post :create, :operation => {:these => 'params'}
        assigns[:operation].should equal(mock_operation)
      end

      it "redirects to the created operation" do
        Operation.stub(:new).and_return(mock_operation(:save => true))
        post :create, :operation => {}
        response.should redirect_to(operation_url(mock_operation))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved operation as @operation" do
        Operation.stub(:new).with({'these' => 'params'}).and_return(mock_operation(:save => false))
        post :create, :operation => {:these => 'params'}
        assigns[:operation].should equal(mock_operation)
      end

      it "re-renders the 'new' template" do
        Operation.stub(:new).and_return(mock_operation(:save => false))
        post :create, :operation => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested operation" do
        Operation.should_receive(:find).with("37").and_return(mock_operation)
        mock_operation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :operation => {:these => 'params'}
      end

      it "assigns the requested operation as @operation" do
        Operation.stub(:find).and_return(mock_operation(:update_attributes => true))
        put :update, :id => "1"
        assigns[:operation].should equal(mock_operation)
      end

      it "redirects to the operation" do
        Operation.stub(:find).and_return(mock_operation(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(operation_url(mock_operation))
      end
    end

    describe "with invalid params" do
      it "updates the requested operation" do
        Operation.should_receive(:find).with("37").and_return(mock_operation)
        mock_operation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :operation => {:these => 'params'}
      end

      it "assigns the operation as @operation" do
        Operation.stub(:find).and_return(mock_operation(:update_attributes => false))
        put :update, :id => "1"
        assigns[:operation].should equal(mock_operation)
      end

      it "re-renders the 'edit' template" do
        Operation.stub(:find).and_return(mock_operation(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested operation" do
      Operation.should_receive(:find).with("37").and_return(mock_operation)
      mock_operation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the operations list" do
      Operation.stub(:find).and_return(mock_operation(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(operations_url)
    end
  end

end
