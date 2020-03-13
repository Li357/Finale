# frozen_string_literal: true

# This model is for convenient importing from school's SQL server
class TeacherCourseRegistration < ApplicationRecord
  belongs_to :teacher
  belongs_to :course
end
