import React from 'react';
import ReactDOM from 'react-dom';
import { ApolloClient, HttpLink, InMemoryCache, ApolloProvider } from '@apollo/client';

import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';
import { FINALE_GRAPHQL_URI } from './utils/constants';

const httpLink = new HttpLink({ uri: FINALE_GRAPHQL_URI, credentials: 'include' });
const client = new ApolloClient({
  cache: new InMemoryCache(),
  link: httpLink,
});

ReactDOM.render(
  <ApolloProvider client={client}>
    <App />
  </ApolloProvider>,
  document.getElementById('root'),
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
