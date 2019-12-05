class User < ApplicationRecord
  belongs_to :organization
  has_many :posts
  has_many :images, as: :imageable
  validates :name, presence: true, length: { maximum: 50 }
  after_create do
    puts "User object was created"
  end

  after_validation do
    puts "User object was validated"
  end

  scope :active, -> { where(active: true) }
  scope :unactive, -> { where(active: false) }
end
