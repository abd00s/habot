module GoalPeriods
  class Satisfaction
    def self.verify!(goal_period:)
      new(goal_period).tap(&:verify!)
    end

    def initialize(goal_period)
      @goal_period = goal_period
    end

    def verify!
      return unless changed?

      @goal_period.update(goal_met: satisfied?)
    end

    private

    def changed?
      @changed ||= @goal_period.goal_met? != satisfied?
    end

    def satisfied?
      @satisfied ||= @goal_period.events.count >= @goal_period.frequency
    end
  end
end
