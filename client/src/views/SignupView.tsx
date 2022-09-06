import { useEffect, useState } from "react";
import { useRouter } from "next/router";
import { authService } from "services/AuthService";
import { toast } from "react-toastify";

export default function SignupView() {
  const [email, setEmail] = useState<string>('');
  const router = useRouter();
  useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      router.push("/");
    }
  }, []);

  const signup = async () => {
    const response = await authService.signup(email);
    if (!(response instanceof Error)) {
      toast.success('Usuário criado com sucesso. Você recebeu um token de acesso via e-mail');
      router.push("/login");
    } else {
      toast.error(response.message);
    }
  }

  const renderHeader = () => {
    return (
      <div>
        <h2 className="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900">
          Criar conta
        </h2>
        <p className="mt-2 text-center text-sm text-gray-600">
          <a href={'/login'} className="font-medium text-indigo-600 hover:text-indigo-500">
            voltar para o login
          </a>
        </p>
      </div>
    )
  }

  const renderEmailInput = () => {
    return (
      <div className="-space-y-px rounded-md shadow-sm">
        <div className="form-control w-full">
          <label className="label">
            <span className="label-text">Digite o seu e-mail</span>
          </label>
          <input type="text" placeholder="E-mail" className="input relative block w-full input-bordered input-primary" onChange={(e) => setEmail(e.target.value)} />
        </div>
      </div>
    )
  }

  const renderSubmitButton = () => {
    return (<div>
      <button className="group relative flex justify-center btn w-full btn-primary" onClick={signup}>Criar</button>
    </div>)
  }

  return (
    <div className="flex min-h-full items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
      <div className="w-full max-w-md space-y-8">
        {renderHeader()}
        {renderEmailInput()}
        {renderSubmitButton()}
      </div>
    </div>
  )
}