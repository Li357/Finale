# frozen_string_literal: true

class Student < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :finals
end
