require "test/unit"
require_relative "./email"

class EmailTest < Test::Unit::TestCase
  test "should create email successfully" do
    input = "joao@gmail.com"

    email = Email.create(input)
    
    assert(email.value, input)
  end

  test "should fail if email is invalid" do
    input = "joao"

    assert_raise RuntimeError do
      email = Email.create(input)
    end
    
  end

  test "should fail if email is empty" do
    input = ""

    assert_raise RuntimeError do
      email = Email.create(input)
    end
    
  end
end