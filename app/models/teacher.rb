class Teacher < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
  belongs_to :department

  has_many :teacher_course_registrations
  has_many :course, through: :teacher_course_registrations
end
