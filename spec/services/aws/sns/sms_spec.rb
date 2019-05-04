require "rails_helper"
require "support/stubs/sns_stub"

module Aws
  module Sns
    RSpec.describe Sms do
      include SnsStub

      before { stub_sns_client }

      describe ".send_single" do
        let(:client) { Aws::SNS::Client.new }

        context "when the required arguments are passed" do
          it "publishes a message to the SNS client" do
            client.expects(:publish).with(payload)

            Aws::Sns::Sms.send_single(payload)
          end
        end
      end

      context "with missing arguments" do
        context "both arguments missing" do
          it "raises ArgumentError error" do
            expect { Aws::Sns::Sms.send_single }.to raise_error(ArgumentError)
          end
        end

        context "phone number  missing" do
          it "raises ArgumentError error" do
            expect do
              Aws::Sns::Sms.send_single(payload.except(:phone_number))
            end.to raise_error(ArgumentError)
          end
        end

        context "message  missing" do
          it "raises ArgumentError error" do
            expect do
              Aws::Sns::Sms.send_single(payload.except(:message))
            end.to raise_error(ArgumentError)
          end
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
