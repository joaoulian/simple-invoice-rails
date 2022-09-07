require_relative "../infrastructure/invoice_repository"
require_relative "../../../shared/domain/email"
require_relative "../domain/aggregates/invoice"

module Application
  module Invoice
    class SendInvoice
      def initialize()
        @invoice_repository = Infra::Repositories::InvoiceRepositoryPostgresImpl.instance
      end

      def execute(invoice_id, dto_emails, actor_id)
        invoice = @invoice_repository.find_by_id(invoice_id)
        rails 'Forbidden' unless invoice.user_id == actor_id

        emails = dto_emails.map { |email| Email.create(email) }

        InvoiceMailer.send_invoice(invoice, emails).deliver_later
      end
    end
  end
end

