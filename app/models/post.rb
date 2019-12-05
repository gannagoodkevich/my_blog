class Post < ApplicationRecord
  belongs_to :user
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

  scope :inactive, -> { where(status: 'inactive') }
  scope :under_review, -> { where(status: 'under_review') }
  scope :add_posts_to_user, ->(arr, id) { arr.each { |arr| Post.create(content: arr, status: "active", user_id: id) } }
end
