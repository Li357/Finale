class User < ApplicationRecord
  has_many :roles

  def student?
    roles.includes? :student
  end

  def teacher?
    roles.includes? :teacher
  end

  def admin?
    roles.includes? :admin
  end

  def as_student
    raise TypeError, "User is not a Student!" unless student?
    Student.find(id)
  end

  def as_teacher
    raise TypeError, "User is not a Teacher" unless teacher?
    Teacher.find(id)
  end

  def as_admin
    raise TypeError, "User is not an Admin" unless admin?
    Admin.find(id)
  end
end
