# This model is for convenient importing from school's SQL server
class StudentCourseRegistration < ApplicationRecord
  belongs_to :student
  belongs_to :course
end
