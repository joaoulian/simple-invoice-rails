import axios, { AxiosInstance } from 'axios'

export class InvoiceService {
  private instance: AxiosInstance

  constructor() {
    this.instance = axios.create({
      baseURL: 'http://localhost:5000/api',
      timeout: 1000,
      headers: {
        Authorization: `${localStorage.getItem('token')}`,
      },
    })
  }

  public async getInvoices(): Promise<any> {
    try {
      const { data } = await this.instance.get(`/invoice`)
      return data.data
    } catch (err) {
      if (axios.isAxiosError(err)) {
        console.log('error message: ', err.message)
        throw new APIError(err.message)
      } else {
        console.log('unexpected error: ', err)
        throw new APIError('An unexpected error occurred')
      }
    }
  }

  public async downloadInvoice(id: string): Promise<any> {
    this.instance({
      url: `/download_invoice?id=${id}`,
      method: 'GET',
      responseType: 'blob', // important
    }).then((response) => {
      const url = window.URL.createObjectURL(new Blob([response.data]))
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', `invoice-${id}.pdf`)
      document.body.appendChild(link)
      link.click()
    })
  }

  public async createInvoice(args: CreateInvoiceArgs): Promise<any> {
    try {
      const { data } = await this.instance.post(`/invoice`, args)
      return data.data
    } catch (err) {
      if (axios.isAxiosError(err)) {
        console.log('error message: ', err.message)
        throw new APIError(err.message)
      } else {
        console.log('unexpected error: ', err)
        throw new APIError('An unexpected error occurred')
      }
    }
  }

  public async sendInvoice(id: string, emails: string[]): Promise<any> {
    try {
      const { data } = await this.instance.post(`/send_invoice`, { id, emails })
      return data
    } catch (err) {
      if (axios.isAxiosError(err)) {
        console.log('error message: ', err.message)
        throw new APIError(err.message)
      } else {
        console.log('unexpected error: ', err)
        throw new APIError('An unexpected error occurred')
      }
    }
  }
}

export interface CreateInvoiceArgs {
  invoice_date: Date
  company_info: string
  total: number
  billing_info: string
  billing_emails: string[]
}

export class APIError extends Error {}
