teacher = User.create(
  username: 'Smith123', first_name: 'John', middle_name: '', last_name: 'Smith', suffix: '',
  profile_photo: 'https://example.com/teacher.jpg'
)

student = User.create(
  username: 'Li357', first_name: 'Andrew', middle_name: '', last_name: 'Li', suffix: '',
  profile_photo: 'https://example.com/student.jpg'
)

Role.create(user_id: student.id, role_type: 0)
Role.create(user_id: teacher.id, role_type: 1)

Student.create(id: student.id)
Teacher.create(id: teacher.id)
