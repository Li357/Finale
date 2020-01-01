import React, { useState, ChangeEvent } from 'react';

import Input from './Input';
import Button from './Button';
import logo from '../assets/WHS.png';
import '../styles/Login.css';

export default function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const onChangeUsername = (event: ChangeEvent<HTMLInputElement>) => {
    setUsername(event.target.value);
  }

  const onChangePassword = (event: ChangeEvent<HTMLInputElement>) => {
    setPassword(event.target.value);
  }

  const disabled = username.length === 0 || password.length === 0;
  return (
    <div className="screen login">
      <div className="login-container">
        <img className="logo" src={logo} alt="WHS Logo" />
        <h1 className="text-title">Sign up for your finals</h1>
        <span className="text-body">Login to your WHS account</span>
        <Input placeholder="Username" value={username} onChange={onChangeUsername} />
        <Input type="password" placeholder="Password" value={password} onChange={onChangePassword} />
        <Button disabled={disabled}>Login</Button>
      </div>
    </div>
  );
}
