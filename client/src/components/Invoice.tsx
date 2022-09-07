export const Invoice = ({ invoice, download, sendToEmail }: InvoiceProps) => {
  return (
    <>

      <div className="grid grid-cols-3 gap-4">
        <p className="text-base p-6">Order Number: <p className="text-sm">{invoice.id}</p></p>
        <p className="text-base p-6"></p>
        <p className="text-base p-6">Order Date: <p className="text-sm">{invoice.date}</p></p>
        <p className="text-base p-6">Company Info<p className="text-sm">{invoice.companyInfo}</p></p>
        <p className="text-base p-6">Bill info<p className="text-sm">{invoice.billTo.info}</p></p>
        <p className="text-base p-6">Bill emails
          <ul className="list-disc">
            {invoice.billTo.emails.map((email, key) => (
              <li key={`invoice-email-${key}`}>{email}</li>
            ))}
          </ul>
        </p>
        <p className="text-base p-6 font-medium">Total<p className="text-sm">{invoice.total}</p></p>
      </div>
      <div className="flex justify-between mb-4">
        <div className="flex items-end justify-end space-x-3">
          <button className="px-4 py-2 btn" onClick={() => download(invoice.id)}>Download</button>
        </div>
      </div>
      <div className="flex justify-between mb-4">
        <div className="flex items-end justify-end space-x-3">
          <button className="px-4 py-2 btn" onClick={() => sendToEmail(invoice.id)}>Enviar por e-mail</button>
        </div>
      </div>


    </>
  )
}

export interface Invoice {
  id: string;
  date: string;
  companyInfo: string;
  total: number;
  billTo: {
    info: string;
    emails: string[]
  }
}

export interface InvoiceProps {
  invoice: Invoice
  download: (id: string) => void
  sendToEmail: (id: string) => void
}