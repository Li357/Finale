# frozen_string_literal: true

class User < ApplicationRecord
  has_many :roles

  def has_roles?(role_types)
    roles.all? { |role| role_types.include?(role.role_type.to_sym) }
  end

  # Admin model is never really used, only for authorization for admin functionsm, only teachers will be admins
  def to_role
    has_roles?([:teacher]) ? Teacher.joins(:user).find_by(user_id: id) : Student.joins(:user).find_by(user_id: id)
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
