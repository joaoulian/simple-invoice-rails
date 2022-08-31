require 'test_helper'
require_relative '../app/shared/domain/email'
require_relative '../app/contexts/invoice/domain/aggregates/invoice'
require_relative '../app/contexts/invoice/domain/aggregates/bill_to'

module Domain
  module Identity
    class InvoiceTest < ActiveSupport::TestCase
      test "should create invoice successfully with existent id" do
        date = Date.parse('31-12-2010')
        company_info = "batata"
        bill_to = BillTo.create("batata", [Email.create("joao@gmail.com")])
        total = 10
        id = "unique-id"
        user_id = "user-id"
    
        invoice = Domain::Invoice.create(date, company_info, bill_to, total, user_id, id)
    
        assert(invoice.id, id)
        assert(invoice.total, total)
        assert(invoice.bill_to, bill_to)
        assert(invoice.company_info, company_info)
        assert(invoice.date, date)
      end

      test "should create invoice successfully" do
        date = Date.parse('31-12-2010')
        company_info = "batata"
        bill_to = BillTo.create("batata", [Email.create("joao@gmail.com")])
        total = 10
        user_id = "user-id"
    
        invoice = Domain::Invoice.create(date, company_info, bill_to, total, user_id)
    
        assert(invoice.total, total)
        assert(invoice.bill_to, bill_to)
        assert(invoice.company_info, company_info)
        assert(invoice.date, date)
      end

      test "should raises error if date is invalid" do
        date = '31-12-2010'
        company_info = "batata"
        bill_to = BillTo.create("batata", [Email.create("joao@gmail.com")])
        total = 10
        user_id = "user-id"
    
        assert_raise RuntimeError do
          invoice = Domain::Invoice.create(date, company_info, bill_to, total, user_id)
        end
      end

      test "should raises error if billTo is invalid" do
        date = Date.parse('31-12-2010')
        company_info = "batata"
        bill_to = [Email.create("joao@gmail.com")]
        total = 10
        user_id = "user-id"
    
        assert_raise RuntimeError do
          invoice = Domain::Invoice.create(date, company_info, bill_to, total, user_id)
        end
      end
    end
  end
end