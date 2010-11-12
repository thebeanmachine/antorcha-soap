require 'spec_helper'

describe "/operations/edit.html.erb" do
  include OperationsHelper

  before(:each) do
    assigns[:operation] = @operation = stub_model(Operation,
      :new_record? => false,
      :message_id => 1
    )
  end

  it "renders the edit operation form" do
    render

    response.should have_tag("form[action=#{operation_path(@operation)}][method=post]") do
      with_tag('input#operation_message_id[name=?]', "operation[message_id]")
    end
  end
end
