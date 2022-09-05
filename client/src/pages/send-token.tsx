import type { NextPage } from 'next'
import { Container } from 'components/Container'
import { useRouter } from 'next/router';
import { useEffect, useState } from 'react';
import { authService } from 'services/AuthService';

const SendToken: NextPage = () => {
  const [email, setEmail] = useState<string>('');
  const router = useRouter();
  useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      router.push("/");
    }
  }, []);

  const generateToken = async () => {
    await authService.generateToken(email);
    router.push("/login");
  }

  return (
    <Container>
      <div className="form-control w-full max-w-xs mb-6">
        <label className="label">
          <span className="label-text">Digite o seu e-mail</span>
        </label>
        <input type="text" placeholder="E-mail" className="input input-bordered w-full max-w-xs" onChange={e => setEmail(e.target.value)} />
        <label className="label">
          <span className="label-text-alt">Enviaremos um token no seu e-mail</span>
        </label>
        <a className="link link-primary label-text-alt" href={'/login'}>Voltar para o login</a>
      </div>
      <button className="btn btn-primary" onClick={generateToken}>Gerar token</button>
    </Container>
  )
}


export default SendToken;
