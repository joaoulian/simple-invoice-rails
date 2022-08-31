require_relative './invoice_model'
require_relative '../domain/repositories/user_repository'
require_relative './user_mapper'

module Infra
  module Repositories
    class InvoiceRepositoryPostgresImpl < Domain::InvoiceRepository
      include Singleton
      
      def initialize()
        @invoice = Infrastructure::Invoice
        @mapper = Infra::Repositories::UserRepositoryMapper.new
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
        invoice = @invoice.where(
          :invoice_date => date.beginning_of_day..date.end_of_day)
        return @mapper.toDomain(invoice)
      end
    end
  end
end