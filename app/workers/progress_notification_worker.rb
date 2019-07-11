class ProgressNotificationWorker
  include Sidekiq::Worker

  def perform(goal_id)
    goal = Goal.find(goal_id)

    Goals::NotificationManager.run(goal: goal)
  end
end
