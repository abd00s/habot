require "rails_helper"

module Events
  RSpec.describe Manager do
    let(:monday) { Time.zone.now.beginning_of_week }
    let(:tuesday) { monday + 1.day }
    let(:goal) { create(:goal) }

    describe ".run" do
      context "when an Event already exists for the date" do
        let(:goal_period) do
          create(:goal_period, goal: goal, start_date: monday)
        end
        let!(:existing_event) do
          create(:event, goal_period: goal_period, date: monday)
        end

        it "does not create a new Event" do
          expect { new_event(monday) }.not_to(change { Event.count })
        end

        it "adds the events#create error to Events::Manager's errors" do
          event_manager = new_event(monday)

          expect { event_manager.valid? }.to change {
            event_manager.errors[:date].size
          }.from(0).to(1)
        end
      end

      context "when no goal_period exists for the period" do
        it "creates a new goal_period record" do
          expect { new_event(monday) }.to change { GoalPeriod.count }
            .from(0).to(1)
        end

        it "creates an Event record associated to the new GoalPeriod" do
          event_manager = new_event(tuesday)

          expect(event_manager.goal_period).to(
            eq(event_manager.event.goal_period)
          )
        end
      end

      context "when a goal_period exists" do
        context "for the same period" do
          let!(:exsisting_goal_period) do
            create(:goal_period, goal: goal, start_date: monday)
          end

          it "creates an Event record associated to the existing GoalPeriod" do
            event_manager = new_event(tuesday)

            expect(event_manager.goal_period).to eq(exsisting_goal_period)
          end
        end

        context "for a past period" do
          let!(:exsisting_goal_period) do
            create(:goal_period, goal: goal, start_date: monday - 7.days)
          end

          it "creates a new goal_period record" do
            expect { new_event(tuesday) }.to change { GoalPeriod.count }
              .from(1).to(2)
          end

          it "creates an Event record associated to the new GoalPeriod" do
            event_manager = new_event(tuesday)

            expect(event_manager.goal_period).to(
              eq(event_manager.event.goal_period)
            )
          end

          it "does not associate Event to the existing GoalPeriod" do
            event_manager = new_event(tuesday)

            expect(event_manager.goal_period).not_to eq(exsisting_goal_period)
          end
        end
      end
    end

    def new_event(day)
      Events::Manager.run(
        goal_id: goal.id,
        date:    day.strftime("%Y-%m-%d")
      )
    end
  end
end
