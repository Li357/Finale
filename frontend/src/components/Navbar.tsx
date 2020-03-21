import React from 'react';
import gql from 'graphql-tag.macro';

import Logo from './Logo';
import '../styles/Navbar.css';
import { useQuery } from '@apollo/client';
import { NavbarUserInfo_user } from '../types/NavbarUserInfo';

const USER_INFO = gql`
  query NavbarUserInfo {
    user {
      name
      photo
    }
  }
`;

export default function Navbar() {
  const { loading, error, data } = useQuery<{ user: NavbarUserInfo_user }>(USER_INFO);

  if (loading) {
    return null;
  }

  return (
    <nav className="navbar">
      <Logo />
      <div className="navbar-profile">
        <span className="navbar-profile-name">{data?.user.name}</span>
        <img className="navbar-profile-photo" src={data?.user.photo || '' /* TODO: blank user if null */} />
      </div>
    </nav>
  );
}
