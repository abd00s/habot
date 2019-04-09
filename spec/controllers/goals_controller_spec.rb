require "rails_helper"

RSpec.describe GoalsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }
    describe "with valid params" do
      it "returns http success" do
        post :create, params: valid_create_params
        expect(response).to have_http_status(:created)
      end
    end

    def valid_create_params
      @valid_create_params ||= {
        goal: {
          user_id:   user.id,
          title:     "test goal",
          frequency: 3,
          period:    "week"
        }
      }
    end
  end
end
