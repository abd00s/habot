class ApplicationController < ActionController::Base
  rescue_from(ActionController::ParameterMissing) do |missing_param_exception|
    errors = [missing_param_exception.param => "is required"]

    render json: { errors: errors }, status: :bad_request
  end
end
