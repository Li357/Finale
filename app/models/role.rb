# frozen_string_literal: true

class Role < ApplicationRecord
  enum role_type: [:student, :teacher, :admin]
  belongs_to :user

  validates :role_type, inclusion: { in: self.role_types.values }
end
