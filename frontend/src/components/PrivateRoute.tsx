import React from 'react';
import { RouteProps, Route, Redirect } from 'react-router-dom';
import cookies from 'js-cookie';
import { FINALE_COOKIE_PAYLOAD } from '../utils/constants';

export default function PrivateRoute({ children, ...rest }: RouteProps) {
  return (
    <Route
      {...rest}
      render={({ location }) => {
        if (cookies.get(FINALE_COOKIE_PAYLOAD)) {
          return children;
        }
        return <Redirect to={{ pathname: '/login', state: { from: location } }} />;
      }}
    />
  );
}
