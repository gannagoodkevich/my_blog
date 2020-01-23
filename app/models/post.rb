class Post < ApplicationRecord
  paginates_per 20

  belongs_to :user
  has_many :images, as: :imageable

  enum status: { inactive: 0, under_review: 1, active: 2, archived: 3}

  validates :status, inclusion: { in: %w[inactive under_review active archived],
                                message: '%{value} is not a valid status' }

  scope :inactive, -> { where(status: 'inactive') }
  scope :under_review, -> { where(status: 'under_review') }
  scope :under_review_or_inactive, -> { where(:status => ['under_review', 'inactive']) }
  scope :with_active_users, ->(organization_id) { joins(:user).where(users: {organization_id: organization_id, active: true}) }
end
