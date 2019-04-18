module Events
  class NewEvent
    include ActiveModel::Validations

    DATE_FOMAT =
      %r{\A(20)\d\d([-/.])(0[1-9]|1[012])\2(0[1-9]|[12][0-9]|3[01])\z}.freeze

    attr_reader :goal, :date, :event, :goal_period

    validates_presence_of :goal, :date
    validates_format_of :date, with: DATE_FOMAT

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
  end
end
