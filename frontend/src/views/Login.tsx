import React, { useState, ChangeEvent } from 'react';
import { Redirect } from 'react-router-dom';
import { useMutation } from '@apollo/client';
import gql from 'graphql-tag.macro';
import cookies from 'js-cookie';

import Input from '../components/Input';
import Button from '../components/Button';
import logo from '../assets/WHS.png';
import '../styles/Login.css';
import { Login_login, LoginVariables } from '../types/Login';
import { FINALE_COOKIE_PAYLOAD } from '../utils/constants';

const LOGIN = gql`
  mutation Login($username: String!, $password: String!) {
    login(username: $username, password: $password) {
      success
    }
  }
`;

export default function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setLoading] = useState(false);
  const [login, { data }] = useMutation<{ login: Login_login }, LoginVariables>(LOGIN);

  if (data?.login.success || cookies.get(FINALE_COOKIE_PAYLOAD)) {
    return <Redirect to="/" />;
  }

  const onChangeUsername = (event: ChangeEvent<HTMLInputElement>) => {
    setUsername(event.target.value);
  };

  const onChangePassword = (event: ChangeEvent<HTMLInputElement>) => {
    setPassword(event.target.value);
  };

  const loginWithCredentials = () => {
    setLoading(true);
    login({ variables: { username, password } });
  };

  const disabled = username.length === 0 || password.length === 0 || isLoading;
  return (
    <div className="screen login">
      <div className="login-container">
        <img className="logo" src={logo} alt="WHS Logo" />
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
