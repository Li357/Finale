# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :department
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :students
  has_many :finals
end
