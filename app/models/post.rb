class Post < ApplicationRecord
  has_one :user
  validates :status, inclusion: { in: %w[inactive under_review active archived],
                                message: "%{value} is not a valid status" }
  after_create do
    puts "Post object was created"
  end

  after_validation do
    puts "Post object was validated"
  end
end
