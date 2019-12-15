class Post < ApplicationRecord
  paginates_per 20
  belongs_to :user
  has_many :images, as: :imageable
  enum status: { inactive: 1, under_review: 2, active: 3, archived: 4 }

  validates :status, inclusion: { in: %w[inactive under_review active archived],
                                message: '%{value} is not a valid status' }
  after_destroy do
    puts 'Post object was destroyed'
  end

  after_create do
    puts 'Post object was created'
  end

  after_validation do
    puts 'Post object was validated'
  end

  after_update do
    puts 'Post was updated!'
  end


  scope :inactive, -> { where(status: 'inactive') }
  scope :under_review, -> { where(status: 'under_review') }
  scope :under_review_or_inactive, -> { where(:status => ['under_review', 'inactive']) }
  scope :with_active_users, -> { joins(:user).where('active = true ') }
end
