class QueueGoalsProgressNotificationsWorker
  include Sidekiq::Worker

  def perform
    goal_ids.each do |goal_id|
      ProgressNotificationWorker.perform_async(goal_id)
    end
  end

  private

  def goal_ids
    Goal.all.pluck(:id)
  end
end
