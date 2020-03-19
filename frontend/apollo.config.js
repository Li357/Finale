const endpoint = process.env.FINALE_GRAPHQL_URI || 'http://localhost:4000/graphql';

module.exports = {
  client: {
    service: {
      name: 'finale',
      url: endpoint,
    },
    includes: ['./src/**/*.ts', './src/**/*.tsx'],
    tagName: 'gql',
  },
};
