# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :department
  has_many :teacher_course_registrations
  has_many :teachers, through: :teacher_course_registrations
  has_many :student_course_registrations
  has_many :students, through: :student_course_registrations
  has_many :finals

  validates :name, presence: true
end
