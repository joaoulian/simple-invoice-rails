require 'test_helper'
require_relative '../app/contexts/identity/domain/aggregates/email'


class EmailTest < ActiveSupport::TestCase
  test "should create email successfully" do
    input = "joao@gmail.com"

    email = Domain::Identity::Email.create(input)
    
    assert(email.value, input)
  end

  test "should fail if email is invalid" do
    input = "joao"

    assert_raise RuntimeError do
      email = Domain::Identity::Email.create(input)
    end
    
  end

  test "should fail if email is empty" do
    input = ""

    assert_raise RuntimeError do
      email = Domain::Identity::Email.create(input)
    end
    
  end
end
