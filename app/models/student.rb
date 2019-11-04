# frozen_string_literal: true

class Student < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
  has_and_belongs_to_many :courses, join_table: :students_courses
  has_and_belongs_to_many :finals, join_table: :students_finals
end
