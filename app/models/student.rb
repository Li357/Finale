# frozen_string_literal: true

class Student < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user

  has_many :student_course_registrations
  has_many :courses, through: :student_course_registrations

  has_many :final_signups
  has_many :finals, through: :final_signups
end
