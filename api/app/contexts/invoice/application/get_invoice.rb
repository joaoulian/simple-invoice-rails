require_relative "../infrastructure/invoice_repository"
require_relative "../../../shared/domain/email"
require_relative "../domain/aggregates/invoice"

module Application
  module Invoice
    class GetInvoice
      def initialize()
        @invoice_repository = Infra::Repositories::InvoiceRepositoryPostgresImpl.instance
      end

      def execute(id, actor_id)
        invoice = @invoice_repository.find_by_id(id)

        rails 'Forbidden' unless invoice.user_id == actor_id

        return invoice
      end
    end
  end
end

