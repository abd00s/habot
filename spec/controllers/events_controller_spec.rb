require "rails_helper"

RSpec.describe EventsController, type: :controller do
  include ActiveSupport::Testing::TimeHelpers

  let(:goal) { create(:goal, frequency: 2) }

  describe "POST #create" do
    context "with params present" do
      it "calls the new event manager passing the params as arguments" do
        mock = Events::Manager.run(valid_create_params[:event])

        Events::Manager.expects(:run)
                       .with(valid_create_params[:event])
                       .returns(mock)

        post :create, params: valid_create_params
      end

      context "when an Event does not exist for the day" do
        it "returns https created response" do
          post :create, params: valid_create_params

          expect(response).to have_http_status(:created)
        end

        it "creates a new Event associated with the goal" do
          expect { post :create, params: valid_create_params }.to change {
            goal.events.count
          }.from(0).to(1)
        end

        it "creates an Event with the correct date" do
          attrs = valid_create_params[:event]

          expect { post :create, params: valid_create_params }.to(
            change do
              Event.joins(goal_period: :goal)
                   .exists?(
                     ["goals.id = #{attrs[:goal_id]}
                     AND events.date = '#{attrs[:date]}'"]
                   )
            end.from(false).to(true)
          )
        end
      end

      context "when an Event exists for the day" do
        let(:date) { Date.parse(valid_create_params.dig(:event, :date)) }
        let!(:event) do
          create(:event,
                 date:        date,
                 goal_period: create(:goal_period,
                                     goal:       goal,
                                     start_date: date.beginning_of_week))
        end

        it "returns http bad_request response" do
          post :create, params: valid_create_params

          expect(response).to have_http_status(:bad_request)
        end

        it "does not create any Events" do
          expect { post :create, params: valid_create_params }.not_to(change do
            Event.count
          end)
        end
      end
    end

    context "with missing params" do
      let(:invalid_params) do
        valid_create_params.tap { |p| p.dig(:event).except!(:date) }
      end

      it "returns http bad request" do
        post :create, params: invalid_params

        expect(response).to have_http_status(:bad_request)
      end

      it "does not create any Events" do
        expect { post :create, params: invalid_params }.not_to(change do
          Event.count
        end)
      end
    end

    context "when goal remains unmet" do
      let!(:goal_period) do
        create(:goal_period,
               goal:       goal,
               start_date: Time.zone.now.beginning_of_week)
      end

      it "does not toggle the goal period's satisfaction to true" do
        expect do
          post :create, params: valid_create_params(Time.zone.now)
        end.not_to(change { goal_period.reload.goal_met? })
      end
    end

    context "when goal becomes met" do
      before(:all) do
        travel_to wednesday_of_next_week
      end

      let(:goal_period) do
        create(:goal_period,
               goal:       goal,
               start_date: Time.zone.now.beginning_of_week)
      end
      let!(:event) do
        create(:event,
               date:        Time.zone.yesterday,
               goal_period: goal_period)
      end

      it "toggles the goal period's satisfaction to true" do
        expect { post :create, params: valid_create_params(Time.zone.now) }.to(
          change { goal_period.reload.goal_met? }.from(false).to(true)
        )
      end
    end

    it "generates documentaion" do
      post :create, params: valid_create_params

      write_docs(request: request, response: response)
    end
  end

  def valid_create_params(date = "2019-01-02")
    @valid_create_params ||= {
      event: {
        goal_id: goal.id,
        date:    date
      }
    }
  end

  def wednesday_of_next_week
    Time.zone.now.next_week.next_day(2)
  end
end
