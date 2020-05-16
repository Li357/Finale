import React, { useState, ChangeEvent } from 'react';
import { Redirect } from 'react-router-dom';
import cookies from 'js-cookie';

import Input from '../components/Input';
import Button from '../components/Button';
import Logo from '../components/Logo';
import { FINALE_COOKIE_PAYLOAD, FINALE_LOGIN_URI } from '../utils/constants';
import '../styles/Login.css';

async function loginWithCredentials(username: string, password: string) {
  const response = await fetch(FINALE_LOGIN_URI, {
    method: 'POST',
    credentials: 'include',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password }),
  });
  return response.ok;
}

function useLogin(): [boolean, (username: string, password: string) => Promise<void>] {
  const [loggedIn, setLoggedIn] = useState(false);
  const login = async (username: string, password: string) => {
    const ok = await loginWithCredentials(username, password);
    setLoggedIn(ok);
  };

  if (!loggedIn && cookies.get(FINALE_COOKIE_PAYLOAD) !== undefined) {
    setLoggedIn(true);
  }
  return [loggedIn, login];
}

export default function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setLoading] = useState(false);
  const [loggedIn, login] = useLogin();

  if (loggedIn) {
    return <Redirect to="/summary" />;
  }

  const onChangeUsername = (event: ChangeEvent<HTMLInputElement>) => {
    setUsername(event.target.value);
  };

  const onChangePassword = (event: ChangeEvent<HTMLInputElement>) => {
    setPassword(event.target.value);
  };

  const loginWithCredentials = async () => {
    setLoading(true);
    try {
      await login(username, password);
    } catch (error) {}
    setLoading(false);
  };

  const disabled = username.length === 0 || password.length === 0 || isLoading;
  return (
    <div className="screen login">
      <div className="login-container">
        <Logo />
        <h1 className="text-title">Sign up for your finals</h1>
        <span className="text-body">Login to your WHS account</span>
        <Input placeholder="Username" value={username} onChange={onChangeUsername} />
        <Input type="password" placeholder="Password" value={password} onChange={onChangePassword} />
        <Button disabled={disabled} onClick={loginWithCredentials}>
          Login
        </Button>
      </div>
    </div>
  );
}
