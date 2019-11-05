# frozen_string_literal: true

class Final < ApplicationRecord
  belongs_to :course
  belongs_to :supervisor, class_name: "Teacher", foreign_key: :teacher_id, primary_key: :user_id, inverse_of: :finals
  has_and_belongs_to_many :students, join_table: :students_finals

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
