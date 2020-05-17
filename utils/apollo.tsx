import { ApolloClient, InMemoryCache, NormalizedCacheObject, HttpLink } from '@apollo/client';
import { NextPageContext } from 'next';
import fetch from 'isomorphic-unfetch';

export default function createApolloClient(
  initialState: NormalizedCacheObject,
  ctx?: NextPageContext,
) {
  return new ApolloClient({
    ssrMode: Boolean(ctx),
    link: new HttpLink({
      uri: process.env.NEXT_PUBLIC_HASURA_URI,
      fetch,
    }),
    cache: new InMemoryCache().restore(initialState),
  });
}