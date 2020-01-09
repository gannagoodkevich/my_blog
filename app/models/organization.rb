class Organization < ApplicationRecord
  paginates_per 20

  has_many :users

  validates :title, presence: true, length: {maximum: 100}
end
