require "rails_helper"

module GoalPeriods
  RSpec.describe Satisfaction do
    describe ".verify!" do
      let(:goal_frequency) { 3 }
      let(:goal) { create(:goal, frequency: goal_frequency) }

      context "when goal is currently unmet for goal_period" do
        let(:goal_period) { create(:goal_period, goal: goal, goal_met: false) }

        context "and remains unmet after run" do
          it "goal_period remains unmet" do
            expect { verify!(goal_period) }.not_to(
              change { goal_period.goal_met }
            )
          end
        end

        context "and becomes met after run" do
          context "when the frequency exceeds the goal" do
            setup do
              goal_period.events.stubs(:count).returns(goal_frequency + 1)
            end

            it "goal_period becomes met (`goal_met` toggled to true)" do
              expect { verify!(goal_period) }.to(
                change { goal_period.goal_met }.from(false).to(true)
              )
            end
          end

          context "when the frequency equals the goal" do
            setup do
              goal_period.events.stubs(:count).returns(goal_frequency)
            end

            it "goal_period becomes met (`goal_met` toggled to true)" do
              expect { verify!(goal_period) }.to(
                change { goal_period.goal_met }.from(false).to(true)
              )
            end
          end
        end

        def verify!(goal_period)
          GoalPeriods::Satisfaction.verify!(goal_period: goal_period)
        end
      end

      context "when goal is currently met for goal_period" do
        context "and remains met after run" do
          context "when the frequency exceeds the goal" do
            it "goal_period remains met" do

            end
          end

          context "when the frequency equals the goal" do
            it "goal_period remains met" do

            end
          end
        end

        context "and becomes unmet after run" do
          it "toggles goal_period `goal_met` to false" do

          end
        end
      end
    end
  end
end
