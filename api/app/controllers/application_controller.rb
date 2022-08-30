require "./app/contexts/identity/infrastructure/jwt_helper"
require "jwt"

class ApplicationController < ActionController::API
  rescue_from Exception do |e|
    # You may want to log more robust information here
    Rails.logger.error("Error message: #{e.message}")

    render json: { error: 'Unexpected Error' }, status: :internal_server_error
  end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebTokenHelper.decode(header)
      @current_user = Infrastructure::Identity::User.find_by(id: @decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end