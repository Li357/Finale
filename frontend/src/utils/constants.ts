export const FINALE_API_URI = process.env.NODE_ENV === 'production' ? '' : 'http://localhost:4000'; // TODO:
export const FINALE_GRAPHQL_URI = `${FINALE_API_URI}/graphql`;
export const FINALE_LOGIN_URI = `${FINALE_API_URI}/login`;
export const FINALE_LOGOUT_URI = `${FINALE_API_URI}/logout`;
export const FINALE_COOKIE_PAYLOAD = '_fp';
