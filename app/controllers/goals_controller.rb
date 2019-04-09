class GoalsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def index
    render json: goals
  end

  def create
    if new_goal.valid?
      render json: new_goal, status: :created
    else
      render json: new_goal.errors.messages, status: :bad_request
    end
  end

  private

  def goals
    @goals ||= Goal.all
  end

  def new_goal
    @new_goal ||= Goal.create(goal_params)
  end

  def goal_params
    params.require(:goal).permit(:user_id, :title, :frequency, :period)
  end
end
