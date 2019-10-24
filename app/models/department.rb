# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :courses
  has_many :users
end
