module Aws
  module Sns
    class Sms < Sns::Base
      attr_reader :phone_number, :message
      def self.send_single(args = {})
        new(args).tap(&:send_single)
      end

      def initialize(args = {})
        @phone_number = args[:phone_number]
        @message      = args[:message]
      end

      def send_single
        client.publish(phone_number: phone_number, message: message)
      end
    end
  end
end
