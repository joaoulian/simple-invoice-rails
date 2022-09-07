require 'test_helper'
require_relative '../../app/contexts/invoice/application/create_invoice'
require_relative '../../app/contexts/identity/application/create_user'
require_relative '../../app/contexts/identity/infrastructure/token_helper'

module Application
  module Invoice
    class CreateInvoiceTest < ActiveSupport::TestCase

      def create_user()
        dto = "joao@gmail.com"
        create_user = Application::User::CreateUser.new
        token = create_user.execute(dto)
        user_id = TokenHelper.instance.get_user_id_from_token(token)
        return user_id
      end

      test "should create invoice succesfully" do
        invoice_date = Date.parse('31-12-2010')
        company_info = "batata"
        billing_info = "batata"
        billing_emails = ["joao@gmail.com"]
        total = 10
        user_id = create_user()
        dto = CreateInvoiceDTO.new(
          invoice_date: invoice_date,
          company_info: company_info, 
          billing_emails: billing_emails, 
          billing_info: billing_info, 
          total: total, 
          user_id: user_id
        )
        create_invoice = CreateInvoice.new
        invoice_repository = Infra::Repositories::InvoiceRepositoryPostgresImpl.instance

        id = create_invoice.execute(dto)

        created_invoice = invoice_repository.find_by_id(id)

        assert(created_invoice.id, id)
        assert(created_invoice.date, invoice_date)
        assert(created_invoice.bill_to.info, billing_info)
        assert(created_invoice.total, total)
        assert(created_invoice.user_id, user_id)
      end
    end
  end
end