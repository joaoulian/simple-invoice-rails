require_relative "../infrastructure/user_repository"
require_relative "../infrastructure/jwt_helper"

module Application
  module User
    class GenerateToken
      def initialize()
        @user_repository = Infra::Repositories::UserRepository.instance
      end

      def execute(email)
        user = @user_repository.find_by_email(email)
        token = JsonWebTokenHelper.encode(user_id: user.id)
        time = Time.now + 24.hours.to_i
        return TokenDTO.new(token, time.strftime("%m-%d-%Y %H:%M"))
      end
    end
  end
end

class TokenDTO
  def initialize(token, exp)
    @token = token
    @exp = exp
  end

  def token
    @token
  end

  def exp
    @exp
  end
end