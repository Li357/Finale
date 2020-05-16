import React from 'react';
import { RouteProps, Route, Redirect } from 'react-router-dom';

import { hasRole } from '../utils/user';
import Container from './Container';

export default function StudentRoute({ children, ...rest }: RouteProps) {
  return (
    <Route
      {...rest}
      render={({ location }) => {
        if (hasRole('student')) {
          return <Container>{children}</Container>;
        }
        return <Redirect to={{ pathname: '/dashboard', state: { from: location } }} />;
      }}
    />
  );
}
