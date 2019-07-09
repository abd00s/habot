class ProgressNotificationWorker
  include Sidekiq::Worker

  def perform
    Aws::Sns::Sms.send_single(
      message:      "from worker",
      phone_number: "Rails.application.credentials.test_data[:phone_number]"
    )
  end
end
