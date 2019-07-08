module GoalPeriods
  class Dummy
    def self.run
      ProgressNotificationWorker.perform_async
    end

    def self.ping
      ProgressNotificationWorker.perform_async
    end
  end
end
