require "rails_helper"

RSpec.describe EventsController, type: :controller do
  let(:goal) { create(:goal) }

  describe "POST #create" do
    context "with missing params" do
      let(:invalid_params) do
        valid_create_params.tap { |p| p.dig(:event).except!(:date) }
      end

      it "returns http bad request" do
        get :create, params: invalid_params

        expect(response).to have_http_status(:bad_request)
      end
    end
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
