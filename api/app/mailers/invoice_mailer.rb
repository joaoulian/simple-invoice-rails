require "prawn"
require_relative "../contexts/invoice/application/invoice_pdf"

class InvoiceMailer < ApplicationMailer
  def send_invoice(invoice, emails)
    @invoice = invoice

    invoice_pdf = InvoicePdf.new(invoice)
    invoice_pdf.header

    attachments["invoice.pdf"] = { :mime_type => "application/pdf" , :content => invoice_pdf.render, :filename => 'invoice.pdf' , :type => "application/pdf" }
    mail(to: emails.map { |email| email["value"] }, subject: "Invoice generated")
  end

end
