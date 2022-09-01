require "prawn"
require_relative "../contexts/invoice/application/invoice_pdf"

class InvoiceMailer < ApplicationMailer
  def send_invoice(invoice)
    @invoice = invoice

    invoice_pdf = InvoicePdf.new
    invoice_pdf.header

    attachments["invoice.pdf"] = { :mime_type => "application/pdf" , :content => invoice_pdf.render, :filename => 'invoice.pdf' , :type => "application/pdf" }
    mail(to: @invoice["bill_to"]["emails"].map { |email| email["value"] }, subject: "Invoice generated")
  end

end
