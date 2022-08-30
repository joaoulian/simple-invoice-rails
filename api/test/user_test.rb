require 'test_helper'
require_relative '../app/shared/domain/email'
require_relative '../app/contexts/identity/domain/aggregates/user'

module Domain
  module Identity
    class UserTest < ActiveSupport::TestCase
      test "should create user successfully with existent id" do
        email = Email.create("joao@gmail.com")
        id = "unique-id"

        user = Domain::Identity::User.create(email, id)

        assert(user.email.value, email.value)
        assert(user.id, id)
      end

      test "should create user successfully" do
        email = Email.create("joao@gmail.com")

        user = Domain::Identity::User.create(email)

        assert(user.email.value, email.value)
        assert_not_nil(user.id)
      end

      test "should raise error if user email is not a email value object" do
        email = "joao@gmail.com"

        assert_raise RuntimeError do
          user = Domain::Identity::User.create(email)
        end
      end
    end
  end
end