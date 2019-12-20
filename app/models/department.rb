# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :courses
  has_many :department_assignments
  has_many :teachers, through: :department_assignments

  validates :name, presence: true
end
