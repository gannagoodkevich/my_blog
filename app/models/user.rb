require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  paginates_per 20

  belongs_to :organization
  has_many :posts
  has_many :images, as: :imageable

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, :presence => true

  before_create :generate_confirmation_token

  scope :active, -> { where(active: true) }
  scope :unactive, -> { where(active: false) }

  def to_param
    "#{id} #{name}".parameterize
  end

  def password
    @password ||= Password.new(self.encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

  def confirm!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    save!
  end

  private

  def generate_confirmation_token
    loop do
      token = SecureRandom.urlsafe_base64
      unless User.where(:confirmation_token => token).any?
        self.confirmation_token = token
        self.confirmation_sent_at = Time.now.utc
        break
      end
    end
  end
end
