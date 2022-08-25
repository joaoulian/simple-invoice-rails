require 'securerandom'

class Invoice
  def initialize(date, company_data, bill_to, total, id)
    @date = date
    @company_data = company_data
    @bill_to = bill_to
    @total = total
    @id = id
  end

  def date
    @date
  end

  def company_data
    @company_data
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

  def self.create(date, company_data, bill_to, total, id =SecureRandom.uuid)
    instance = new(date, company_data, bill_to, total, id)
    return instance
  end
end