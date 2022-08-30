require "./app/contexts/identity/infrastructure/token_helper"

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
      user_id = TokenHelper.instance.get_user_id_from_token(header)
      @current_user = Infrastructure::Identity::User.find_by(id: user_id)
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end