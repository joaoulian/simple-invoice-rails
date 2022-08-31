require 'securerandom'
require_relative './bill_to'

module Domain
  class Invoice
    def initialize(date, company_info, bill_to, total, user_id, id)
      @date = date
      @company_info = company_info
      @bill_to = bill_to
      @total = total
      @user_id = user_id
      @id = id
    end

    def date
      @date
    end

    def company_info
      @company_info
    end

    def bill_to
      @bill_to
    end

    def total
      @total
    end

    def id
      @id
    end

    private_class_method :new

    def self.create(date, company_info, bill_to, total, user_id, id =SecureRandom.uuid)
      raise 'Invalid bill to' unless bill_to.instance_of? BillTo
      raise 'Invalid date' unless date.instance_of? Date
      instance = new(date, company_info, bill_to, total, user_id, id)
      return instance
    end
  end
end