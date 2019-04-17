require "rails_helper"

module GoalPeriods
  RSpec.describe Retriever do
    let(:monday) { Time.zone.now.beginning_of_week }
    let(:tuesday) { monday + 1.day }
    let(:goal) { create(:goal) }

    describe ".run" do
      context "when no goal_period exists for the period" do
        it "creates a new goal_period record" do
          expect { retrieve_goal_period(monday) }.to change { GoalPeriod.count }
            .from(0).to(1)
        end

        context "when the event date is a Monday" do
          it "creates a goal_period starting on the Monday" do
            goal_period = retrieve_goal_period(monday)

            expect(goal_period.start_date).to eq(monday)
          end
        end

        context "when the event date is a Tuesday" do
          it "creates a goal_period starting on the prior Monday of the week" do
            goal_period = retrieve_goal_period(tuesday)

            expect(goal_period.start_date).to eq(monday)
          end
        end
      end
    end

    context "when a goal_period exists for the period" do
      let!(:exsisting_goal_period) { retrieve_goal_period(monday) }

      it "does not create a new goal_period record" do
        expect { retrieve_goal_period(tuesday) }.not_to(
          change { GoalPeriod.count }
        )
      end

      it "returns the existing goal_period record" do
        goal_period = retrieve_goal_period(tuesday)

        expect(goal_period).to eq(exsisting_goal_period)
      end
    end

    def retrieve_goal_period(day)
      GoalPeriods::Retriever.run(
        goal: goal,
        date: day
      ).goal_period
    end
  end
end
