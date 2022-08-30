require_relative "../infrastructure/user_repository"

module Application
  module User
    class FindUserById
      def initialize(repositories = {})
        @user_repository = Infra::Repositories::UserRepository.new
      end

      def find_by_id(id)
        @user_repository.find_by_id(id)
      end
    end
  end
end