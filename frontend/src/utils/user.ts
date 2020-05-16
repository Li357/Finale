import cookies from 'js-cookie';

import { FINALE_COOKIE_PAYLOAD } from './constants';
import { UserPayload, Role } from '../types/User';

export function hasRole(role: Role) {
  const encodedUser = cookies.get(FINALE_COOKIE_PAYLOAD);
  if (encodedUser === undefined) {
    return false;
  }
  const { roles }: UserPayload = JSON.parse(atob(encodedUser));
  return roles.includes(role);
}
