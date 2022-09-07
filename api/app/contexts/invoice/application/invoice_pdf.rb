require "prawn"

class InvoicePdf
  include Prawn::View

  def initialize(invoice)
    @invoice = invoice
  end
  
  def header
    move_down 30
    text "Invoice #{@invoice.id}" , :style => :bold , :size => 14
    text "Company: #{@invoice.company_info}" , :size => 12
    text "Bill to: #{@invoice.bill_to.info}" , :size => 12
    text "Total: #{@invoice.total}" , :size => 12
    text "Invoice date: #{@invoice.date}" , :size => 12
    move_down 30
    text "generated #{Date.today}" , :size => 8
  end

end