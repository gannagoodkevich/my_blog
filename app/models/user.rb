class User < ApplicationRecord
  paginates_per 20

  belongs_to :organization
  has_many :posts
  has_many :images, as: :imageable

  validates :name, presence: true, length: { maximum: 50 }

  scope :active, -> { where(active: true) }
  scope :unactive, -> { where(active: false) }

  def to_param
    "#{id} #{name}".parameterize
  end
end
