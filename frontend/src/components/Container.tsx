import React, { ReactNode } from 'react';

import Navbar from './Navbar';
import '../styles/Container.css';

interface ContainerProps {
  children: ReactNode;
}

export default function Container({ children }: ContainerProps) {
  return (
    <div className="container">
      <Navbar />
      {children}
    </div>
  );
}
