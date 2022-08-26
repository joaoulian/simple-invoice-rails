class Api::UsersController < ApplicationController
  def show
    user = Application::User::FindUserById.new.find_by_id(params.dig(:user_id))

    render json: user, status: :ok
  end
end