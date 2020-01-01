import React, { InputHTMLAttributes } from 'react';

import '../styles/Input.css';

export default function Input(props: InputHTMLAttributes<{}>) {
  return (
    <input className="text-body" {...props} />
  );
}
