require_relative "../infrastructure/user_repository"
require_relative "../infrastructure/token_helper"

module Application
  module User
    class SendNewTokenToEmail
      def initialize()
        @user_repository = Infra::Repositories::UserRepository.instance
      end

      def execute(email)
        user = @user_repository.find_by_email(email)
        token = TokenHelper.instance.generate_token(user.id)

        IdentityMailer.send_token(user.email.value, token).deliver_later
      end
    end
  end
end