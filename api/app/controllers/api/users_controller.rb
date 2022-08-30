require_relative "../../contexts/identity/application/find_user_by_id"
require_relative '../application_controller'

class Api::UsersController < ApplicationController
  def show
    user = Application::User::FindUserById.new.find_by_id(params.dig(:user_id))

    render json: user, status: :ok
  end
end