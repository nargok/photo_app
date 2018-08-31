class User < ApplicationRecord
  validates :user_id, presence: true,
            uniqueness: { case_sensitive: false }
  validates :password, presence: true
end
