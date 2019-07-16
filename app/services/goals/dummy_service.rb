module Goals
  class DummyService
    def self.run
      new.tap(&:run)
    end

    def run
      Aws::Sns::Sms.send_single(
        phone_number: Rails.application.credentials.test_data[:phone_number],
        message:      "Message from dummy worker."
      )
    end
  end
end
