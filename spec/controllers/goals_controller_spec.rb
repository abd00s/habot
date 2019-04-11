require "rails_helper"

RSpec.describe GoalsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "generates documenation" do
      create(:goal)

      get :index
      write_docs(request: request, response: response)
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }

    describe "with valid params" do
      it "returns http success" do
        post :create, params: valid_create_params
        expect(response).to have_http_status(:created)
      end

      it "creates a Goal record" do
        expect { post :create, params: valid_create_params }.to(
          change { Goal.count }.by(1)
        )
      end

      it "generates documenation" do
        post :create, params: valid_create_params

        write_docs(request: request, response: response)
      end
    end

    describe "with a missing params" do
      let(:invalid_params) do
        valid_create_params.tap { |p| p.dig(:goal).except!(:title) }
      end

      it "returns http failure" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:bad_request)
      end

      it "creates a Goal record" do
        expect { post :create, params: invalid_params }.to_not(
          change { Goal.count }
        )
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
