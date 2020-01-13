require 'bcrypt'

class UserAuth < ActiveRecord::Base
  include BCrypt
  validates :email, :presence => true

  before_create :generate_confirmation_token

  def password
    @password ||= Password.new(self.encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

  def confirm!
    self.conf_token = nil
    self.confirmed_at = Time.now.utc
    self.save!
  end

  private

  def generate_confirmation_token
    loop do
      token = SecureRandom.urlsafe_base64
      unless UserAuth.where(:conf_token => token).any?
        self.conf_token = token
        self.confirm_sent_at = Time.now.utc
        break
      end
    end
  end
end