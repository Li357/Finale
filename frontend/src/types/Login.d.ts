/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL mutation operation: Login
// ====================================================

export interface Login_login {
  __typename: "LoginPayload";
  success: boolean;
}

export interface Login {
  /**
   * Login with username and password
   */
  login: Login_login | null;
}

export interface LoginVariables {
  username: string;
  password: string;
}
