require_relative './invoice_model'
require_relative '../domain/repositories/invoice_repository'
require_relative './invoice_mapper'

module Infra
  module Repositories
    class InvoiceRepositoryPostgresImpl < Domain::InvoiceRepository
      include Singleton
      
      def initialize()
        @invoice = Infrastructure::Invoice
        @mapper = Infra::Repositories::InvoiceRepositoryMapper.new
      end

      def save(domain)
        invoice = @mapper.toPersistance(domain)
        invoice.save
      end

      def find_by_id(id)
        invoice = @invoice.find_by(id: id)
        return @mapper.toDomain(invoice)
      end

      def find_by_date(date)
        invoices = @invoice.where(
          :invoice_date => date.beginning_of_day..date.end_of_day)
        return invoices.map { |invoice| @mapper.toDomain(invoice) }
      end

      def get_invoices_by_user_id(user_id)
        invoices = @invoice.where(user_id: user_id)
        return invoices.map { |invoice| @mapper.toDomain(invoice) }
      end
    end
  end
end