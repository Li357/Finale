class Admin < ApplicationRecord
  self.primary_key = :user_id
  belongs_to :user
end
