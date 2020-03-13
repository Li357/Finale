# frozen_string_literal: true

class Final < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :supervisors, class_name: "Teacher", join_table: :teacher_final_assignments
  has_and_belongs_to_many :students, join_table: :student_final_signups

  validates :mod, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 8 }
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :room, presence: true

  def signups
    students.length
  end

  def signup(student, &block)
    students << student
    save(&block)
  end
end
