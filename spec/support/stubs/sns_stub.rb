module SnsStub
  def stub_sns_client
    mock = Aws::SNS::Client.new(stub_responses: true)

    Aws::SNS::Client.stubs(:new)
                    .returns(mock)
  end
end
