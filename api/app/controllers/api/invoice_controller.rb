require_relative "../../contexts/invoice/application/create_invoice"
require_relative "../../contexts/invoice/application/get_invoices"
require_relative "../../contexts/invoice/application/get_invoice"
require_relative "../../contexts/invoice/application/invoice_pdf"
require_relative "../../contexts/invoice/application/send_invoice"
require_relative '../application_controller'
require 'json'

class Api::InvoiceController < ApplicationController
  before_action :authorize_request

  def create
    dto = Application::Invoice::CreateInvoiceDTO.new(
      invoice_date: Date.strptime(invoice_params[:invoice_date], '%Y-%m-%d'),  # YYYY-MM-DD
      company_info: invoice_params[:company_info], 
      billing_emails: invoice_params[:billing_emails], 
      billing_info: invoice_params[:billing_info], 
      total: invoice_params[:total], 
      user_id: @current_user.id
    )

    Application::Invoice::CreateInvoice.new.execute(dto)

    render json: { success: true }, status: :ok
  end

  def get_invoices
    invoices = Application::Invoice::GetInvoices.new.execute(@current_user.id)

    render json: { data: invoices }, status: :ok
  end

  def download_invoice
    invoice = Application::Invoice::GetInvoice.new.execute(params[:id], @current_user.id)
    invoice_pdf = InvoicePdf.new(invoice.as_json)
    invoice_pdf.header

    send_data invoice_pdf.render,
              filename: "invoice.pdf",
              type: "application/pdf"
  end

  def send_invoice
    Application::Invoice::SendInvoice.new.execute(send_invoice_params[:id], send_invoice_params[:emails], @current_user.id)
    render json: { success: true}, status: :ok
  end

  private
    def invoice_params
      params.permit([
        :billing_info,
        :invoice_date,
        :company_info,
        :total,
        :billing_emails => []
      ])
    end

    def send_invoice_params
      params.permit([
        :id,
        :emails => []
      ])
    end
end
