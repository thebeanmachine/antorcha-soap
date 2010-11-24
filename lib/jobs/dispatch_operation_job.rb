class Jobs::DispatchOperationJob < Struct.new(:operation_id)
  def perform
    @operation = Operation.find(operation_id)
    @operation.dispatch
  end

end