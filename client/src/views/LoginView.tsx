import { useEffect, useState } from "react";
import { useRouter } from "next/router";

export default function LoginView() {
  const [token, setToken] = useState<string>('');
  const router = useRouter();

  useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      router.push("/");
    }
  }, []);

  const submitToken = () => {
    localStorage.setItem('token', token);
    router.push("/");
  }

  const renderHeader = () => {
    return (
      <div>
        <h2 className="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900">
          Acesse sua conta
        </h2>
        <p className="mt-2 text-center text-sm text-gray-600">
          ou{' '}
          <a href={'/sign-up'} className="font-medium text-indigo-600 hover:text-indigo-500">
            crie uma nova conta
          </a>
        </p>
      </div>
    )
  }

  const renderTokenInput = () => {
    return (
      <div className="-space-y-px rounded-md shadow-sm">
        <div className="form-control w-full">
          <label className="label">
            <span className="label-text">Digite o token de acesso</span>
          </label>
          <input type="text" placeholder="Digite o token de acesso aqui" className="input relative block w-full input-bordered input-primary" onChange={(e) => setToken(e.target.value)} />
          <label className="label">
            <span className="label-text-alt">Você provavelmente recebeu um token via e-mail</span>
          </label>
        </div>
      </div>
    )
  }

  const renderExtraOptions = () => {
    return (
      <div className="flex items-center justify-between">
        <div className="text-sm">
          <a href={'/send-token'} className="font-medium text-indigo-600 hover:text-indigo-500">
            Reenviar token
          </a>
        </div>
      </div>
    )
  }

  const renderSubmitButton = () => {
    return (<div>
      <button className="group relative flex justify-center btn w-full btn-primary" onClick={submitToken}>Entrar</button>
    </div>)
  }

  return (
    <div className="flex min-h-full items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
      <div className="w-full max-w-md space-y-8">
        {renderHeader()}
        {renderTokenInput()}
        {renderExtraOptions()}
        {renderSubmitButton()}
      </div>
    </div>
  )
}