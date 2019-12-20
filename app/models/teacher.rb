# frozen_string_literal: true

class Teacher < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
  has_many :department_assignments
  has_many :departments, through: :department_assignments
  has_many :teacher_course_registrations
  has_many :courses, through: :teacher_course_registrations
  has_and_belongs_to_many :finals, join_table: :teacher_final_assignments
end
