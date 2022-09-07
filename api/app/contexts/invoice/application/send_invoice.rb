require_relative "../infrastructure/invoice_repository"
require_relative "../../../shared/domain/email"
require_relative "../domain/aggregates/invoice"
require_relative "./invoice_pdf"

module Application
  module Invoice
    class SendInvoice
      def initialize()
        @invoice_repository = Infra::Repositories::InvoiceRepositoryPostgresImpl.instance
      end

      def execute(invoice_id, dto_emails, actor_id)
        invoice = @invoice_repository.find_by_id(invoice_id)
        raise 'Forbidden' unless invoice.user_id == actor_id

        emails = dto_emails.map { |email| Email.create(email) }

        invoice_pdf = InvoicePdf.new(invoice)
        invoice_pdf.header
        InvoiceMailer.send_invoice(invoice_pdf.render, emails.map { |email| email.value }, invoice.id).deliver_later
        
      end
    end
  end
end

