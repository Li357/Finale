import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import Login from './views/Login';
import PrivateRoute from './components/PrivateRoute';
import Summary from './views/Summary';
import './App.css';

export default function App() {
  return (
    <Router>
      <Switch>
        <Route exact path="/login">
          <Login />
        </Route>
        <PrivateRoute path="/">
          <Summary />
        </PrivateRoute>
      </Switch>
    </Router>
  );
}
