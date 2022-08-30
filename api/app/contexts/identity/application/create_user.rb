require_relative "../infrastructure/user_repository"
require_relative "../../../shared/domain/email"
require_relative "../domain/aggregates/user"

module Application
  module User
    class CreateUser
      def initialize()
        @user_repository = Infra::Repositories::UserRepository.instance
      end

      def execute(emailDto)
        email = Email.create(emailDto)
        user = Domain::Identity::User.create(email)

        @user_repository.save(user)

        token = TokenHelper.instance.generate_token(user.id)

        IdentityMailer.send_token(email.value, token).deliver_later

        return token
      end
    end
  end
end