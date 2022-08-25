require "test/unit"
require_relative "./user"
require_relative "./email"

class UserTest < Test::Unit::TestCase
  test "should user email successfully with existent id" do
    email = Email.create("joao@gmail.com")
    id = "unique-id"

    user = User.create(email, id)

    assert(user.email.value, email.value)
    assert(user.id, id)
  end

  test "should user email successfully" do
    email = Email.create("joao@gmail.com")

    user = User.create(email)

    assert(user.email.value, email.value)
    assert_not_nil(user.id)
  end
end