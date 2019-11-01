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
  def to_role
    if teacher?
      Teacher.joins(:user).find_by(user_id: id)
    else
      Student.joins(:user).find_by(user_id: id)
    end
  end

  def name
    [first_name, middle_name, last_name, suffix]
      .reject { |c| c.empty? }
      .join(" ")
  end

  def photo
    profile_photo
  end
end
