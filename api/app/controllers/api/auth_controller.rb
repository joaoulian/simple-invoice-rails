require_relative "../../contexts/identity/application/send_new_token_to_email"
require_relative '../application_controller'

class Api::AuthController < ApplicationController
  def generate_token
    token = Application::User::SendNewTokenToEmail.new.execute(auth_params[:email])
    render json: { msg: 'Token sent to email successfully' }, status: :ok
  end

  private
    def auth_params
      params.permit([:email])
    end
end
