# frozen_string_literal: true

class Final < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :students
end
