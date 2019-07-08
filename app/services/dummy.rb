class Dummy
  def self.run
    ProgressNotificationWorker.perform_async
  end
end
