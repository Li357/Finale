teacher = User.create(
  username: 'Smith123', first_name: 'John', middle_name: '', last_name: 'Smith', suffix: '',
  profile_photo: 'https://example.com/teacher.jpg'
)

student = User.create(
  username: 'Li357', first_name: 'Andrew', middle_name: '', last_name: 'Li', suffix: '',
  profile_photo: 'https://example.com/student.jpg'
)

department = Department.create(name: 'Mathematics')

Role.create(user: student, role_type: :student)
Role.create(user: teacher, role_type: :teacher)

Student.create(user: student)
Teacher.create(user: teacher, department: department)
