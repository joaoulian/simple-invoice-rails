require_relative "../infrastructure/user_repository"
require_relative "../infrastructure/token_helper"

module Application
  module User
    class FindUserById
      def initialize()
        @user_repository = Infra::Repositories::UserRepository.instance
      end

      def execute(id, actor_id)
        user = @user_repository.find_by_id(id)
        raise 'Forbidden' unless user.id == actor_id

        return UserDTO.new(user.email.value, user.id)
      end
    end

    UserDTO = Struct.new(:email, :id)

  end
end