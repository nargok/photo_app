class Photo < ApplicationRecord
  validates :title, presence: true
  validates :filename, presence: true

  belongs_to :user
end
