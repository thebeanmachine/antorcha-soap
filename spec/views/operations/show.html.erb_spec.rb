require 'spec_helper'

describe "/operations/show.html.erb" do
  include OperationsHelper
  before(:each) do
    assigns[:operation] = @operation = stub_model(Operation,
      :message_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
  end
end
