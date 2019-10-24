# frozen_string_literal: true

class TeacherCourseRegistration < ApplicationRecord
  belongs_to :teacher
  belongs_to :course
end
