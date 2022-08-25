require "test/unit"
require "date"
require_relative "./invoice"
require_relative "./bill_to"
require_relative "../../../shared/email"


class InvoiceTest < Test::Unit::TestCase
  test "should user email successfully with existent id" do
    date = Date.parse('31-12-2010')
    company_data = "batata"
    bill_to = BillTo.create("batata", Array.new(1) { Email.create("joao@gmail.com") })
    total = 10
    id = "unique-id"

    invoice = Invoice.create(date, company_data, bill_to, total, id)

    assert(invoice.id, id)
  end
end