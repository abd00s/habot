class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    if event_manager.valid?
      render json: event_manager.event, status: :created
    else
      render json: event_manager.errors, status: :bad_request
    end
  end

  private

  def event_manager
    @event_manager ||= Events::Manager.create_new(
      goal_id: event_params[:goal_id].to_i,
      date:    event_params[:date]
    )
  end

  def event_params
    attrs = %w[goal_id date]
    params.require(:event).permit(*attrs).tap do |event_params|
      attrs.each { |attr| event_params.require(attr) }
    end
  end
end
