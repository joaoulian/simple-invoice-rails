require_relative "../../contexts/identity/application/find_user_by_id"
require_relative "../../contexts/identity/application/create_user"
require_relative '../application_controller'

class Api::UsersController < ApplicationController
  def show
    user = Application::User::FindUserById.new.execute(request.headers["token"])
    render json: user, status: :ok
  end

  def create
    id = Application::User::CreateUser.new.execute(user_params[:email])
    render json: { success: true, id: id }, status: :ok
  end

  private
    def user_params
      params.require(:user).permit([
        :email
      ])
    end
end