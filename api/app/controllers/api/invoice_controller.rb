require_relative "../../contexts/invoice/application/create_invoice"
require_relative "../../contexts/invoice/application/get_invoices"
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
end
