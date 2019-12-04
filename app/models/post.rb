class Post < ApplicationRecord
  has_one :user
  has_many :images, as: :imageable
  enum status: %i[inactive under_review active archived]
  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true

  after_destroy do
    puts "Post object was destroyed"
  end

  after_create do
    puts "Post object was created"
  end

  after_validation do
    puts "Post object was validated"
  end

  after_update do
    puts "Post was updated!"
  end
end
