import type { NextPage } from 'next'
import { useEffect, useState } from 'react';
import { Container } from 'components/Container'
import { useRouter } from 'next/router';
import { UserService } from 'services/UserService';
import { Navbar } from 'components/Navbar';

const Home: NextPage = () => {
  const [user, setUser] = useState<any | null>(null);
  const router = useRouter();

  useEffect(() => {
    const token = localStorage.getItem("token");
    if (!token) {
      router.push("/login");
    }

    const user = new UserService();
    user.getUserData().then(
      data => setUser(data)
    ).catch(error => router.push("/login"))
  }, []);

  const goToCreateInvoicePage = () => {
    console.log('go to create invoice page')
  }

  const logout = () => {
    localStorage.removeItem('token');
    router.push("/login");
  }

  return (
    <Container>
      <Navbar email={user?.email?.value ?? 'Default'} createInvoiceCallback={goToCreateInvoicePage} logoutCallback={logout} />
    </Container>
  )
}


export default Home
