# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :courses
  has_and_belongs_to_many :teachers
end
