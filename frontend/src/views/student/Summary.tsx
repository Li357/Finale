import React from 'react';
import gql from 'graphql-tag.macro';

const FINALS = gql`
  query SummaryFinals {
    user {
      ...StudentCourses
    }
  }

  fragment StudentCourses on Student {
    courses
  }
`;

export default function Summary() {
  return <div></div>;
}
