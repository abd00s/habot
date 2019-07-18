module Events
  class Manager
    attr_reader :event, :goal_period

    include ActiveModel::Validations

    validate :event_created

    def self.run(args = {})
      manager = new(args)

      manager.create_new_event
      manager.run_satisfaction_check

      manager
    end

    def initialize(args = {})
      @goal = Goal.find(args[:goal_id])
      @date = Date.parse(args[:date])
    end

    def create_new_event
      @event = Event.create(
        goal_period: goal_period,
        date:        @date
      )
    end

    def run_satisfaction_check
      return if goal_period.goal_met?

      GoalPeriods::Satisfaction.verify!(goal_period: goal_period)
    end

    # rubocop:disable Lint/DuplicateMethods
    def goal_period
      @goal_period ||= GoalPeriods::Retriever.run(
        goal: @goal,
        date: @date
      ).goal_period
    end
    # rubocop:enable Lint/DuplicateMethods

    private

    def event_created
      return if @event.valid?

      errors.merge!(@event.errors)
    end
  end
end
