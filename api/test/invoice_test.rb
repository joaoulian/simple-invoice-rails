require 'test_helper'
require_relative '../app/shared/domain/email'
require_relative '../app/contexts/invoice/domain/aggregates/invoice'
require_relative '../app/contexts/invoice/domain/aggregates/bill_to'

module Domain
  module Identity
    class InvoiceTest < ActiveSupport::TestCase
      test "should create invoice successfully with existent id" do
        date = Date.parse('31-12-2010')
        company_data = "batata"
        bill_to = BillTo.create("batata", [Email.create("joao@gmail.com")])
        total = 10
        id = "unique-id"
    
        invoice = Domain::Invoice.create(date, company_data, bill_to, total, id)
    
        assert(invoice.id, id)
        assert(invoice.total, total)
        assert(invoice.bill_to, bill_to)
        assert(invoice.company_data, company_data)
        assert(invoice.date, date)
      end

      test "should create invoice successfully" do
        date = Date.parse('31-12-2010')
        company_data = "batata"
        bill_to = BillTo.create("batata", [Email.create("joao@gmail.com")])
        total = 10
    
        invoice = Domain::Invoice.create(date, company_data, bill_to, total)
    
        assert(invoice.total, total)
        assert(invoice.bill_to, bill_to)
        assert(invoice.company_data, company_data)
        assert(invoice.date, date)
      end

      test "should raises error if date is invalid" do
        date = '31-12-2010'
        company_data = "batata"
        bill_to = BillTo.create("batata", [Email.create("joao@gmail.com")])
        total = 10
    
        assert_raise RuntimeError do
          invoice = Domain::Invoice.create(date, company_data, bill_to, total)
        end
      end

      test "should raises error if billTo is invalid" do
        date = Date.parse('31-12-2010')
        company_data = "batata"
        bill_to = [Email.create("joao@gmail.com")]
        total = 10
    
        assert_raise RuntimeError do
          invoice = Domain::Invoice.create(date, company_data, bill_to, total)
        end
      end
    end
  end
end