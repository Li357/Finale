import React from 'react';
import { ButtonHTMLAttributes } from 'react';

import '../styles/Button.css';

export default function Button(props: ButtonHTMLAttributes<{}>) {
  return (
    <button className="text-body" {...props}>

    </button>
  );
}
