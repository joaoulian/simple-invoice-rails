require_relative "../../contexts/identity/application/generate_token"
require_relative '../application_controller'

class Api::AuthController < ApplicationController
  def generate_token
    response = Application::User::GenerateToken.new.execute(auth_params[:email])
    render json: { token: response.token, exp: response.exp }, status: :ok
  end

  private
    def auth_params
      params.permit([:email])
    end
end
