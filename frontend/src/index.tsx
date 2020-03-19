import React from 'react';
import ReactDOM from 'react-dom';
import { ApolloLink, ApolloClient, HttpLink, InMemoryCache, ApolloProvider, from } from '@apollo/client';
import Cookies from 'js-cookie';

import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';
import { LOGIN_TOKEN_NAME } from './utils/constants';

const authLink = new ApolloLink((operation, forward) => {
  operation.setContext(({ headers }: { headers: Record<string, string> }) => ({
    headers: {
      Authorization: `Bearer ${Cookies.get(LOGIN_TOKEN_NAME)}`,
      ...headers,
    },
  }));
  return forward(operation);
});
const httpLink = new HttpLink({ uri: 'http://localhost:4000/graphql' });
const link = from([authLink, httpLink]);

const client = new ApolloClient({
  cache: new InMemoryCache(),
  link: link,
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
