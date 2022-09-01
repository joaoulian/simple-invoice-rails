require_relative "../infrastructure/invoice_repository"
require_relative "../../../shared/domain/email"
require_relative "../domain/aggregates/invoice"

module Application
  module Invoice
    class GetInvoices
      def initialize()
        @invoice_repository = Infra::Repositories::InvoiceRepositoryPostgresImpl.instance
      end

      def execute(user_id)
        return @invoice_repository.get_invoices_by_user_id(user_id)
      end
    end
  end
end

