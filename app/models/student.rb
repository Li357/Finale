# frozen_string_literal: true

class Student < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
  has_and_belongs_to_many :courses, join_table: :students_courses
  has_many :final_signups
  has_many :finals, through: :final_signups

  def attended_courses
    courses.as_json(include: :finals)
  end

  def registered_finals
    FinalSignup
      .joins(:final)
      .select("finals.id", "finals.mod", "finals.capacity", "COUNT(1) AS signed_up", "finals.room")
      .group("finals.id")
      .where(student_id: id)
      .as_json
  end
end
