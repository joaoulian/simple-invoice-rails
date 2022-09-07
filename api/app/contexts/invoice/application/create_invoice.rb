require_relative "../infrastructure/invoice_repository"
require_relative "../../../shared/domain/email"
require_relative "../domain/aggregates/invoice"
require_relative "./invoice_pdf"

module Application
  module Invoice
    class CreateInvoice
      def initialize()
        @invoice_repository = Infra::Repositories::InvoiceRepositoryPostgresImpl.instance
      end

      def execute(dto)
        emails = dto.billing_emails.map { |email| Email.create(email) }
        bill_to = BillTo.create(dto.billing_info, emails)

        invoice = Domain::Invoice.create(dto.invoice_date, dto.company_info, bill_to, dto.total, dto.user_id)

        @invoice_repository.save(invoice)

        invoice_pdf = InvoicePdf.new(invoice)
        invoice_pdf.header
        InvoiceMailer.send_invoice(invoice_pdf.render, emails.map { |email| email.value }, invoice.id).deliver_later

        return invoice.id
      end
    end

    class CreateInvoiceDTO
      attr_reader :invoice_date, :company_info, :billing_emails, :billing_info, :total, :user_id
    
      def initialize(invoice_date:, company_info:, billing_emails:, billing_info:, total:, user_id:)
        @invoice_date = invoice_date
        @company_info = company_info
        @billing_emails = billing_emails
        @billing_info = billing_info
        @total = total
        @user_id = user_id
      end
    end
  end
end

