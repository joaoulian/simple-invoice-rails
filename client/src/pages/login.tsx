import type { NextPage } from 'next'
import { Container } from 'components/Container'
import { useEffect, useState } from 'react';
import { useRouter } from 'next/router';

const Login: NextPage = () => {
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

  return (
    <Container>
      <div className="form-control w-full max-w-xs mb-6">
        <label className="label">
          <span className="label-text">Digite o token para entrar</span>
        </label>
        <input type="text" placeholder="Type here" className="input input-bordered w-full max-w-xs" onChange={(e) => setToken(e.target.value)} />
        <label className="label">
          <span className="label-text-alt">Você deve ter recebido um token pelo e-mail</span>
        </label>
        <a className="link link-primary label-text-alt" href={'/send-token'}>Não tenho nenhum Token</a>
      </div>
      <button className="btn btn-primary" onClick={submitToken}>Login</button>
    </Container>
  )
}


export default Login;
