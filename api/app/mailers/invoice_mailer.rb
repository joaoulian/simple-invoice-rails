require_relative "../contexts/invoice/application/invoice_pdf"

class InvoiceMailer < ApplicationMailer
  def send_invoice(pdf, emails, invoice_id)
    @pdf = pdf
    @invoice_id = invoice_id
    attachments["invoice.pdf"] = { :mime_type => "application/pdf" , :content => pdf, :filename => 'invoice.pdf' , :type => "application/pdf" }
    mail(to: emails, subject: "Invoice generated")
  end

end
