module Goals
  class ProgressNotification
    def self.compose(goal:)
      new(goal).compose
    end

    def initialize(goal)
      @goal = goal
    end

    def compose
      "#{@goal.title}: #{message}"
    end

    def message
      return goal_met_message if goal_period.goal_met?
      return goal_attainable_message if goal_attainable?
      return performance_critical_message if performance_critical?

      goal_missed_message
    end

    def goal_period
      @goal_period ||= GoalPeriods::Retriever.run(
        goal: @goal,
        date: today
      ).goal_period
    end

    def goal_met_message
      I18n.t("notifications.goal.met",
             number_of_events: progress, frequency: @goal.frequency)
    end

    def goal_attainable_message
      I18n.t("notifications.goal.attainable",
             number_of_events: progress,
             frequency:        @goal.frequency,
             days_remaining:   days_remaining,
             delta:            delta)
    end

    def performance_critical_message
      I18n.t("notifications.goal.critical",
             number_of_events: progress,
             frequency:        @goal.frequency,
             days_remaining:   days_remaining)
    end

    def goal_missed_message
      I18n.t("notifications.goal.missed",
             number_of_events: progress,
             frequency:        @goal.frequency,
             days_remaining:   days_remaining)
    end

    def goal_attainable?
      delta < days_remaining
    end

    def performance_critical?
      delta == days_remaining
    end

    def delta
      @delta ||= @goal.frequency - progress
    end

    def progress
      @progress ||= goal_period.events.count
    end

    def days_remaining
      @days_remaining ||= 7 - today.cwday + 1
    end

    def today
      @today ||= Time.zone.today
    end
  end
end
