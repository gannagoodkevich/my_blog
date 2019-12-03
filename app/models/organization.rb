class Organization < ApplicationRecord
  has_many :users
  validates :title, presence: true, length: { maximum: 100 }
end
