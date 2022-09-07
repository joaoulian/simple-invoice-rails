import { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import { UserService } from 'services/UserService';
import { InvoiceService } from 'services/InvoiceService';
import { toast } from 'react-toastify';
import { Invoice } from 'components/Invoice';
import { InvoiceModal, ModalInvoice } from 'components/InvoiceModal';
import { SendInvoiceModal } from 'components/SendInvoiceModal';

export default function HomeView() {
  const [user, setUser] = useState<any | null>(null);
  const [invoices, setInvoices] = useState<any[]>([]);
  const [selectedInvoice, setSelectedInvoice] = useState<any>(null);
  const [showCreateInvoiceModal, setShowCreateInvoiceModal] = useState<boolean>(false);
  const [showSendInvoiceModal, setShowSendInvoiceModal] = useState<string | null>(null);
  const router = useRouter();

  useEffect(() => {
    const token = localStorage.getItem("token");
    if (!token) {
      router.push("/login");
    }

    const user = new UserService();
    user.getUserData().then(
      data => updateUserAndFetchInvoices(data)
    ).catch(_error => router.push("/login"))
  }, []);

  const updateUserAndFetchInvoices = (user) => {
    setUser(user)
    const invoiceService = new InvoiceService();
    invoiceService.getInvoices().then(
      data => setInvoices(data)
    ).catch(_error => toast.error('Falha ao carregar invoices'))
  }

  const logout = () => {
    localStorage.removeItem('token');
    router.push("/login");
  }

  const createInvoice = async (args: ModalInvoice) => {
    const invoiceService = new InvoiceService();
    await invoiceService.createInvoice({
      billing_emails: args.emails,
      billing_info: args.billTo,
      company_info: args.companyInfo,
      invoice_date: args.date,
      total: args.total
    });
  }

  const renderHeader = () => {
    return (
      <div className="lg:flex lg:items-center lg:justify-between">
        <div className="min-w-0 flex-1">
          <h2 className="text-2xl font-bold leading-7 text-gray-900 sm:truncate sm:text-3xl sm:tracking-tight">
            Hello
          </h2>
          <div className="mt-1 flex flex-col sm:mt-0 sm:flex-row sm:flex-wrap sm:space-x-6">
            <div className="mt-2 flex items-center text-sm text-gray-500">
              {user?.email}
            </div>
          </div>
        </div>
        <div className="mt-5 flex lg:mt-0 lg:ml-4">
          <span className="ml-3">
            <button className="inline-flex items-center  btn btn-primary" onClick={() => setShowCreateInvoiceModal(true)}>Create invoice</button>
          </span>

          <span className="ml-3">
            <button className="inline-flex items-center  btn btn-ghost" onClick={() => logout()}>Logout</button>
          </span>
        </div>
      </div>
    )
  }

  const downloadInvoice = async (invoiceId: string) => {
    const invoiceService = new InvoiceService();
    await invoiceService.downloadInvoice(invoiceId);
  }

  const sendEmail = async (invoiceId: string, emails: string[]) => {
    const invoiceService = new InvoiceService();
    await invoiceService.sendInvoice(invoiceId, emails);
  }

  const renderSelectedInvoice = (listInvoice) => {
    if (selectedInvoice && selectedInvoice.id === listInvoice.id) return (
      <Invoice invoice={{
        id: selectedInvoice.id,
        billTo: {
          emails: selectedInvoice.bill_to.emails.map(email => email.value),
          info: selectedInvoice.bill_to.info
        },
        companyInfo: selectedInvoice.company_info,
        date: selectedInvoice.date,
        total: selectedInvoice.total
      }}
        download={downloadInvoice}
        sendToEmail={(id: string) => setShowSendInvoiceModal(id)}
      />
    )
  }

  const renderTable = () => {
    return (
      <div className="overflow-x-auto">
        <h3 className="text-lg font-medium leading-6 text-gray-900 mb-3">Invoices</h3>
        <table className="table w-full">
          <thead>
            <tr>
              <th>Número</th>
              <th>Data</th>
              <th>Total</th>
            </tr>
          </thead>
          <tbody>
            {invoices.map((invoice, key) => (
              <>
                <tr key={`invoice-${key}`} className="hover" onClick={() => {
                  if (selectedInvoice?.id === invoice.id) setSelectedInvoice(null)
                  else setSelectedInvoice(invoice)
                }}>
                  <th>{invoice.id}</th>
                  <td>{invoice.date}</td>
                  <td>{invoice.total}</td>
                </tr>
                {renderSelectedInvoice(invoice)}
              </>
            ))}
          </tbody>
        </table>
      </div>
    )
  }

  return (
    <>
      <div className="flex min-h-full items-center justify-center py-12 px-4 sm:px-6">
        <div className="w-full space-y-8">
          {user ?
            <>
              {renderHeader()}
              {renderTable()}
            </> :
            <progress className="progress w-56"></progress>}
        </div>
      </div>
      <InvoiceModal open={showCreateInvoiceModal} closeDialog={() => setShowCreateInvoiceModal(false)} onSave={createInvoice} />
      <SendInvoiceModal open={!!showSendInvoiceModal} closeDialog={() => setShowSendInvoiceModal(null)} onSend={sendEmail} invoiceId={showSendInvoiceModal ?? ''} />
    </>

  )
}