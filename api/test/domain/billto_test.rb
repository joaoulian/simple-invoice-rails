require 'test_helper'
require_relative '../../app/shared/domain/email'
require_relative '../../app/contexts/invoice/domain/aggregates/bill_to'

module Domain
  module Identity
    class BillToTest < ActiveSupport::TestCase
      test "should create bill to succesfully" do
        emails = [Email.create("joao@gmail.com")]
        info = "info"

        billTo = BillTo.create(info, emails)

        assert(billTo.emails[0].value, emails[0])
        assert(billTo.info, info)
      end

      test "should raises error if emails contains a invalid email" do
        emails = ["joaogabrielulian@gmail.com"]
        info = "info"

        assert_raise RuntimeError do
          BillTo.create(info, emails)
        end
      end
    end
  end
end