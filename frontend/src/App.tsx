import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import Login from './views/Login';
import StudentRoute from './components/StudentRoute';
import Summary from './views/student/Summary';
import './App.css';
import TeacherRoute from './components/TeacherRoute';

export default function App() {
  return (
    <Router>
      <Switch>
        <Route exact path="/login">
          <Login />
        </Route>
        <StudentRoute path="/summary">
          <Summary />
        </StudentRoute>
      </Switch>
    </Router>
  );
}
