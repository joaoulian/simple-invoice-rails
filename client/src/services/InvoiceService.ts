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
}

export class APIError extends Error {}
