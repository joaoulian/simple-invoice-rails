require 'test_helper'
require_relative '../../app/contexts/identity/application/create_user'
require_relative '../../app/contexts/identity/application/find_user_by_id'
require_relative '../../app/contexts/identity/infrastructure/token_helper'

module Application
  module User
    class FindUserByIdTest < ActiveSupport::TestCase
      test "should return user sucessfully" do
        dto = "joao@gmail.com"
        create_user = CreateUser.new
        find_user_by_id = FindUserById.new

        token = create_user.execute(dto)
        user_id = TokenHelper.instance.get_user_id_from_token(token)
        user = find_user_by_id.execute(user_id, user_id)

        assert(user.id, user_id)
      end

      test "should raise error if actor id don't have access to user" do
        dto = "joao@gmail.com"
        create_user = CreateUser.new
        find_user_by_id = FindUserById.new

        token = create_user.execute(dto)
        user_id = TokenHelper.instance.get_user_id_from_token(token)

        assert_raise RuntimeError do
          find_user_by_id.execute(user_id, 'any-id')
        end
      end
    end
  end
end