import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

// import Navbar from './components/Navbar';
import Login from './views/Login';
import './App.css';

function Authenticated() {
  return null;
}

export default function App() {
  return (
    <Router>
      <Switch>
        <Route exact path="/login">
          <Login />
        </Route>
        <Route path="/">
          <Authenticated />
        </Route>
        <Route></Route>
      </Switch>
    </Router>
  );
}
