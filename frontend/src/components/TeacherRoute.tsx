import React from 'react';
import { RouteProps, Route, Redirect } from 'react-router-dom';

import { hasRole } from '../utils/user';
import Container from './Container';

export default function TeacherRoute({ children, ...rest }: RouteProps) {
  return (
    <Route
      {...rest}
      render={({ location }) => {
        if (hasRole('teacher')) {
          return <Container>{children}</Container>;
        }
        return <Redirect to={{ pathname: '/login', state: { from: location } }} />;
      }}
    />
  );
}
