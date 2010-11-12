require 'spec_helper'

describe "/operations/index.html.erb" do
  include OperationsHelper

  before(:each) do
    assigns[:operations] = [
      stub_model(Operation,
        :message_id => 1
      ),
      stub_model(Operation,
        :message_id => 1
      )
    ]
  end

  it "renders a list of operations" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
