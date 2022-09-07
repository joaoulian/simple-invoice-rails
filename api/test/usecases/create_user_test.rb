require 'test_helper'
require_relative '../../app/contexts/identity/application/create_user'
require_relative '../../app/contexts/identity/infrastructure/token_helper'

module Application
  module User
    class CreateUserTest < ActiveSupport::TestCase
      test "should create user succesfully" do
        dto = "joao@gmail.com"
        create_user = CreateUser.new
        user_repository = Infra::Repositories::UserRepository.instance

        token = create_user.execute(dto)

        user_id = TokenHelper.instance.get_user_id_from_token(token)
        user = user_repository.find_by_id(user_id)

        assert(user.id, user_id)
      end
      test "should raise error if email is invalid" do
        dto = "joao"
        create_user = CreateUser.new

        assert_raise RuntimeError do
          create_user.execute(dto)
        end
      end
    end
  end
end