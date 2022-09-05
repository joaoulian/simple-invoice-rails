require "./app/contexts/identity/infrastructure/token_helper"

class ApplicationController < ActionController::API
  before_action :cors_set_access_control_headers

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

  def cors_preflight_check
    return unless request.method == 'OPTIONS'
    cors_set_access_control_headers
    render json: {}
  end

  protected
  
  def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, ' \
      'Auth-Token, Email, X-User-Token, X-User-Email, x-xsrf-token'
    response.headers['Access-Control-Max-Age'] = '1728000'
    response.headers['Access-Control-Allow-Credentials'] = true
  end

end