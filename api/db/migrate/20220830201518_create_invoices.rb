class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices, id: :uuid do |t|
      t.date :invoice_date, null: false
      t.string :company_info, null: false
      t.float :total, null: false
      t.text :billing_info, null: false
      t.string :billing_emails, array: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, references: :uuid, type: :uuid, null: false

      t.timestamps
    end
  end
end
