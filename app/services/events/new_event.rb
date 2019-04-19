module Events
  class NewEvent
    attr_reader :event, :goal_period

    def self.create(args = {})
      new(args).tap(&:create)
    end

    def initialize(args = {})
      @goal = args[:goal]
      @date = args[:date]
    end

    def create
      @event = Event.create(
        goal_period: goal_period,
        date:        @date
      )
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
