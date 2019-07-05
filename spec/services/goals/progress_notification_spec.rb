require "rails_helper"

module Goals
  RSpec.describe ProgressNotification do
    include ActiveSupport::Testing::TimeHelpers

    describe ".compose" do
      let(:goal_frequency) { 2 }
      let(:goal) { create(:goal, frequency: goal_frequency) }

      context "when goal is attainable" do
        before(:all) { travel_to wednesday_of_next_week }
        let(:goal_period) { create(:goal_period, goal: goal, goal_met: false) }
        let!(:event) do
          create(:event, goal_period: goal_period, date: Time.zone.yesterday)
        end
        let(:number_of_events) { 1 }
        let(:wednesday_to_sunday) { 5 }
        let(:check_ins_required) { 1 }

        it "provides the attainable message" do
          expected_update = I18n.t("notifications.goal.attainable",
                                   number_of_events: number_of_events,
                                   frequency:        goal.frequency,
                                   days_remaining:   wednesday_to_sunday,
                                   delta:            check_ins_required)
          expected = "#{goal.title}: #{expected_update}"
          actual = compose(goal)

          expect(actual).to eq(expected)
        end

        context "and performace today is critical" do
          before(:all) { travel_to sunday_of_next_week }
          let(:sunday_inclusive) { 1 }

          it "provides the critical message" do
            expected_update = I18n.t("notifications.goal.critical",
                                     number_of_events: number_of_events,
                                     frequency:        goal.frequency,
                                     days_remaining:   sunday_inclusive,
                                     delta:            check_ins_required)

            expected = "#{goal.title}: #{expected_update}"
            actual = compose(goal)

            expect(actual).to eq(expected)
          end
        end
      end

      context "when goal has been met" do
        before(:all) { travel_to wednesday_of_next_week }
        let(:goal_period) { create(:goal_period, goal: goal, goal_met: true) }
        setup do
          2.times do |i|
            create(:event,
                   goal_period: goal_period,
                   date:        Time.zone.now - i)
          end
        end

        let(:number_of_events) { 2 }
        let(:wednesday_to_sunday) { 5 }

        it "provides the satisfaction message" do
          expected_update = I18n.t("notifications.goal.met",
                                   number_of_events: number_of_events,
                                   frequency:        goal.frequency,
                                   days_remaining:   wednesday_to_sunday)
          expected = "#{goal.title}: #{expected_update}"
          actual = compose(goal)

          expect(actual).to eq(expected)
        end
      end

      context "when goal has been missed" do
        before(:all) { travel_to sunday_of_next_week }
        let(:goal_period) { create(:goal_period, goal: goal, goal_met: false) }
        setup do
          goal.update(frequency: 3)
          create(:event,
                 goal_period: goal_period,
                 date:        Time.zone.now - 1)
        end

        let(:number_of_events) { 1 }
        let(:sunday_inclusive) { 1 }

        it "provides the satisfaction message" do
          expected_update = I18n.t("notifications.goal.missed",
                                   number_of_events: number_of_events,
                                   frequency:        goal.frequency,
                                   days_remaining:   sunday_inclusive)
          expected = "#{goal.title}: #{expected_update}"
          actual = compose(goal)

          expect(actual).to eq(expected)
        end
      end

      context "when no events are logged at all" do
        before(:all) { travel_to wednesday_of_next_week }

        let(:number_of_events) { 0 }
        let(:wednesday_to_sunday) { 5 }
        let(:check_ins_required) { goal.frequency }

        it "provides the satisfaction message" do
          expected_update = I18n.t("notifications.goal.attainable",
                                   number_of_events: number_of_events,
                                   frequency:        goal.frequency,
                                   days_remaining:   wednesday_to_sunday,
                                   delta:            check_ins_required)
          expected = "#{goal.title}: #{expected_update}"
          actual = compose(goal)

          expect(actual).to eq(expected)
        end
      end
    end

    def compose(goal)
      Goals::ProgressNotification.compose(goal: goal)
    end

    def wednesday_of_next_week
      Time.zone.now.next_week.next_day(2)
    end

    def sunday_of_next_week
      Time.zone.now.next_week.next_day(6)
    end
  end
end
