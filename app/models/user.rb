class User < ApplicationRecord
  paginates_per 20

  belongs_to :organization
  has_many :posts
  has_many :images, as: :imageable

  validates :name, presence: true, length: { maximum: 50 }

  after_validation :validate
  after_create :create

  scope :active, -> { where(active: true) }
  scope :unactive, -> { where(active: false) }

  private

  def create
    puts "User object was created"
  end

  def validate
    puts "User object was validated"
  end
end
