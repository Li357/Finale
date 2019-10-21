class User < ApplicationRecord
  enum role: [:admin, :student, :teacher]

  belongs_to :department

  # for teachers and students
  has_many :course_registration
  has_many :course, through: :course_registration

  # for students
  has_many :final_signups
  has_many :finals, through: :final_signups
end
