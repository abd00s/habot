module GoalPeriods
  class Dummy
    def self.run
      ProgressNotificationWorker.perform_async
    end

    def self.ping
      "pong"
    end
  end
end
