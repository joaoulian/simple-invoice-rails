module Application
  module User
    class FindUserById
      def initialize(repositories = {})
        @user_repository = repositories.fetch(:user) { Infra::Repositories::UserRepository.new }
      end

      def find_by_id(id)
        @user_repository.find_by_id(id)
      end
    end
  end
end