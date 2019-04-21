require "rails_helper"

RSpec.describe EventsController, type: :controller do
  let(:goal) { create(:goal) }

  describe "POST #create" do
    context "with params present" do
      it "calls the new event manager passing the params as arguments" do
        mock = Events::NewEvent.create(valid_create_params[:event])

        Events::NewEvent.expects(:create)
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
  end

  it "generates documentaion" do
    post :create, params: valid_create_params

    write_docs(request: request, response: response)
  end

  def valid_create_params
    @valid_create_params ||= {
      event: {
        goal_id: goal.id,
        date:    "2019-01-02"
      }
    }
  end
end
