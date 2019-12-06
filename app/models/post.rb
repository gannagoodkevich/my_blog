class Post < ApplicationRecord
  belongs_to :user
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

  scope :under_review, -> { where(status: 'under_review') }
  scope :under_review_or_inactive, -> { where(:status => ['under_review', 'inactive']) }
  scope :with_active_users, -> { joins(:user).where('active = true ') }
end
