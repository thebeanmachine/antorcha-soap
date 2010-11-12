require 'spec_helper'

describe "/operations/new.html.erb" do
  include OperationsHelper

  before(:each) do
    assigns[:operation] = stub_model(Operation,
      :new_record? => true,
      :message_id => 1
    )
  end

  it "renders new operation form" do
    render

    response.should have_tag("form[action=?][method=post]", operations_path) do
      with_tag("input#operation_message_id[name=?]", "operation[message_id]")
    end
  end
end
