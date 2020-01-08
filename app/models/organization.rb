class Organization < ApplicationRecord
  paginates_per 20

  has_many :users

  validates :title, presence: true, length: { maximum: 100 }

  after_validation :after_org_validation
  after_create :after_org_create

  private

  def after_org_create
    puts "Organization object was created"
  end

  def after_org_validation
    puts "Organization object was created"
  end
end
