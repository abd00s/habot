module Aws
  module Sns
    class Base
      def client
        @client ||= Aws::SNS::Client.new(
          region:      aws_credentials[:sns_region],
          credentials: credentials
        )
      end

      def credentials
        @credentials ||= Aws::Credentials.new(
          aws_credentials[:access_key_id],
          aws_credentials[:secret_access_key]
        )
      end

      private

      def aws_credentials
        @aws_credentials ||= Rails.application.credentials.aws
      end
    end
  end
end
