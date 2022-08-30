require_relative "../infrastructure/user_repository"
require_relative "../domain/aggregates/email"
require_relative "../domain/aggregates/user"

module Application
  module User
    class CreateUser
      def initialize()
        @user_repository = Infra::Repositories::UserRepository.instance
      end

      def execute(emailDto)
        email = Domain::Identity::Email.create(emailDto)
        user = Domain::Identity::User.create(email)

        @user_repository.save(user)

        token = TokenHelper.instance.generate_token(user.id)

        return token
      end
    end
  end
end