import React, { useState } from "react";



export const SendInvoiceModal = (props: SendInvoiceModalProps) => {
  const [emails, setEmails] = useState<string[]>([]);
  const [currentEmail, setCurrentEmail] = useState<string>('');

  const onSend = () => {
    props.onSend(props.invoiceId, emails);
  }

  const handleEmail = (event: React.KeyboardEvent) => {
    if (event.key === 'Enter') {
      const tempEmails = [...emails];
      if (!tempEmails.includes(currentEmail)) tempEmails.push(currentEmail);
      setCurrentEmail('')
      setEmails(tempEmails)
    }
  }

  const removeEmail = (email: string) => {
    const tempEmails = [...emails];
    const index = tempEmails.findIndex(item => item === email);
    if (index >= 0) tempEmails.splice(index, 1);
    setEmails(tempEmails);
  }

  const renderEmails = () => {
    return (
      <div className="form-control w-full mb-8">
        <label className="label" htmlFor="role-name">
          <span className="label-text">E-mail dos responsáveis</span>
          <span className="label-text-alt">*</span>
        </label>
        <input
          className="input input-bordered w-full max-w-lg"
          type="text"
          placeholder="Digite o e-mail e aperte enter"
          name="role-name"
          value={currentEmail}
          onChange={e => setCurrentEmail(e.target.value)}
          onKeyDown={(e) => handleEmail(e)}
        />
      </div>
    )
  }

  const renderEmailList = () => {
    return (
      <>
        {emails.map((email, key) => (
          <div className="flex items-center justify-between" key={`allow-list-user-${key}`}>
            <div className="flex items-center gap-4">
              <span className="text-lg font-medium">{email}</span>
            </div>
            <div className="flex items-center">
              <span className="text-base-300 hover:text-base-content" onClick={() => removeEmail(email)}>
                remover
              </span>
            </div>
          </div>
        ))}
      </>
    )
  }

  return (
    <div className={`modal modal-bottom sm:modal-middle ${props.open ? 'modal-open' : ''}`} id="role_modal">
      <div className="modal-box">
        <button onClick={props.closeDialog} className="btn btn-sm btn-circle absolute right-4 top-4">✕</button>
        <h2 className="font-bold text-lg">Enviar invoice</h2>
        <div className="py-4">
          {renderEmails()}
          {renderEmailList()}
        </div>
        <div className="modal-action flex items-center justify-center">
          <button className="btn btn-primary" onClick={onSend}> Enviar </button>
        </div>
      </div>
    </div>
  )
}

interface SendInvoiceModalProps {
  open: boolean;
  closeDialog: () => void;
  onSend(id: string, emails: string[]): void;
  invoiceId: string;
}
