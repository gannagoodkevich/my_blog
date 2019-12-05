class Organization < ApplicationRecord
  has_many :users
  validates :title, presence: true, length: { maximum: 100 }

  after_create do
    puts "Organization object was created"
  end

  after_validation do
    puts "Organization object was validated"
  end
end
