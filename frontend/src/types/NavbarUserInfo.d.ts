/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: NavbarUserInfo
// ====================================================

export interface NavbarUserInfo_user {
  __typename: "Student" | "Teacher";
  /**
   * Name of the user
   */
  name: string;
  /**
   * Profile picture URL of user
   */
  photo: string | null;
}

export interface NavbarUserInfo {
  user: NavbarUserInfo_user | null;
}
