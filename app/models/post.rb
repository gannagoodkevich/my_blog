class Post < ApplicationRecord
  belongs_to :user
  validates :status, inclusion: { in: %w[inactive under_review active archived],
                                message: "%{value} is not a valid status" }
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

  scope :inactive, -> { where(status: 'inactive') }
  scope :under_review, -> { where(status: 'under_review') }
  scope :add_posts_to_user, ->(arr, id) { arr.each { |arr| Post.create(content: arr, status: "active", user_id: id) } }
end
