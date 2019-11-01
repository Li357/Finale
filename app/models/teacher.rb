# frozen_string_literal: true

class Teacher < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
  belongs_to :department
  has_and_belongs_to_many :courses, join_table: :teachers_courses
end
