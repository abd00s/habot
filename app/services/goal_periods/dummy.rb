module GoalPeriods
  class Dummy
    def self.run
      ProgressNotificationWorker.perform_async
    end
  end
end
