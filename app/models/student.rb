# frozen_string_literal: true

class Student < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
  has_many :student_course_registrations
  has_many :courses, through: :student_course_registrations
  has_and_belongs_to_many :finals, join_table: :student_final_signups
end
