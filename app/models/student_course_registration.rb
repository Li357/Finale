# frozen_string_literal: true

class StudentCourseRegistration < ApplicationRecord
  belongs_to :student
  belongs_to :course
end
