require_relative "../infrastructure/user_repository"
require_relative "../infrastructure/token_helper"

module Application
  module User
    class FindUserById
      def initialize()
        @user_repository = Infra::Repositories::UserRepository.instance
      end

      def execute(id)
        @user_repository.find_by_id(id)
      end
    end
  end
end