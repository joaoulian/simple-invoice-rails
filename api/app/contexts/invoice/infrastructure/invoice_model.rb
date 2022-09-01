module Infrastructure
  class Invoice < ApplicationRecord
    attribute :id, :string
    attribute :invoice_date, :date
    attribute :company_info, :string
    attribute :total, :float
    attribute :billing_info, :string
    attribute :billing_emails, :string, array: true
    attribute :user_id, :string
  end
end