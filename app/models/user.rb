# frozen_string_literal: true

class User < ApplicationRecord
  has_many :roles

  def student?
    roles.any? { |role| role.student? }
  end

  def teacher?
    roles.any? { |role| role.teacher? }
  end

  def admin?
    roles.any? { |role| role.admin? }
  end

  # Admin model is never really used, only for authorization for admin functionsm, only teachers will be admins
  def self.as_role(user)
    return unless user
    if user.teacher?
      Teacher.find_by(id: user.id)
    elsif user.student?
      Student.find_by(id: user.id)
    end
  end
end
