type Role = 'student' | 'teacher' | 'admin';
export interface UserPayload {
  id: number;
  roles: Role[];
}
