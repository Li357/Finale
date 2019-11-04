# frozen_string_literal: true

class Role < ApplicationRecord
  enum role_type: [:student, :teacher, :admin]
  belongs_to :user
end
