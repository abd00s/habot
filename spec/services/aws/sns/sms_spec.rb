require "rails_helper"
require "support/stubs/sns_stub"

module Aws
  module Sns
    RSpec.describe Sms do
      include SnsStub
      before { stub_sns_client }

      describe ".send_single" do
        it "publishes a message to the SNS client" do
          client = Aws::SNS::Client.new
          client.expects(:publish).with(payload)

          Aws::Sns::Sms.send_single(payload)
        end
      end

      def payload
        @payload ||= {
          phone_number: "12345",
          message:      "sample test"
        }
      end
    end
  end
end
