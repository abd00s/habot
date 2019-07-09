class ProgressNotificationWorker
  include Sidekiq::Worker

  def perform
    Aws::Sns::Sms.send_single(
      message:      "from worker",
      phone_number: "+16474442435"
    )
  end
end
