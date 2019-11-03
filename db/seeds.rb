teacherUser = User.create(
  username: 'Smith123', first_name: 'John', middle_name: '', last_name: 'Smith', suffix: '',
  profile_photo: 'https://example.com/teacher.jpg'
)

studentUser = User.create(
  username: 'Li357', first_name: 'Andrew', middle_name: '', last_name: 'Li', suffix: '',
  profile_photo: 'https://example.com/student.jpg'
)

department = Department.create(name: 'Mathematics')
algebra = Course.create(name: 'Algebra', department: department)

Role.create(user: studentUser, role_type: :student)
Role.create(user: teacherUser, role_type: :teacher)

student = Student.create(user: studentUser, courses: [algebra])
teacher = Teacher.create(user: teacherUser, departments: [department], courses: [algebra])

capacity = 15
Final.create(supervisor: teacher, course: algebra, students: [student], mod: 1, capacity: capacity, room: 'Rm. 325')
