class User < ApplicationRecord
  belongs_to :organization
  has_many :posts
  validates :active, presence: true
  validates :name, presence: true, length: { maximum: 50 }
end
