class GoalsController < ApplicationController
  def index
    render json: { goals: goals }
  end

  private

  def goals
    @goals ||= Goal.all
  end
end
