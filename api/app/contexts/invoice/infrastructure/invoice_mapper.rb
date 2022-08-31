require_relative '../domain/aggregates/invoice'
require_relative '../domain/aggregates/bill_to'
require_relative '../../../shared/domain/email'
require_relative './invoice_model'

module Infra
  module Repositories
    class InvoiceRepositoryMapper
      def toDomain(model)
        emails = model.billing_emails.map { |email| Email.create(email) }
        bill_to = BillTo.create(model.billing_info, emails)
        return Domain::Invoice.create(model.invoice_date, model.company_info, bill_to, model.total, model.user_id, model.id)
      end

      def toPersistance(domain)
        return Infrastructure::Invoice.new(
          id: domain.id,
          invoice_date: domain.date,
          company_info: domain.company_info,
          total: domain.total,
          billing_info: domain.bill_to.info,
          billing_emails: domain.bill_to.get_emails_list(),
          user_id: domain.user_id
        )
      end
    end
  end
end