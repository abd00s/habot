module Aws
  module Sns
    class Sms < Sns::Base
      attr_reader :phone_number, :message

      include ActiveModel::Validations

      validates_presence_of :phone_number, :message

      def self.send_single(args = {})
        new(args).tap(&:send_single)
      end

      def initialize(args = {})
        @phone_number = args[:phone_number]
        @message      = args[:message]

        raise ArgumentError, errors.messages unless valid?
      end

      def send_single
        client.publish(phone_number: phone_number, message: message)
      end
    end
  end
end
