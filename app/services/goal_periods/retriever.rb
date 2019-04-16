module GoalPeriods
  class Retriever
    attr_reader :goal_period

    def self.run(args = {})
      new(args).tap(&:run)
    end

    def initialize(args = {})
      @goal = args[:goal]
      @date = args[:date]
    end

    def run
      @goal_period = GoalPeriod.find_or_create_by(
        goal:       @goal,
        start_date: period_start_date
      )
    end

    private

    def period_start_date
      @period_start_date ||= @date.beginning_of_week
    end
  end
end
