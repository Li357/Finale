# frozen_string_literal: true

class Teacher < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
  has_and_belongs_to_many :departments, join_table: :teachers_departments
  has_and_belongs_to_many :courses, join_table: :teachers_courses
  has_many :finals, inverse_of: :supervisor
end
