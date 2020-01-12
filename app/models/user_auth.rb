require 'bcrypt'

class UserAuth < ActiveRecord::Base
  include BCrypt
  attr_accessor :email
  validates :email, :presence => true

  before_create :generate_confirmation_token

  def password
    @password ||= Password.new(self.password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
  end

  def confirm!
    self.conf_token = nil
    self.confirmed_at = Time.now.utc
    self.save
  end

  private

  def generate_confirmation_token
    loop do
      token = SecureRandom.urlsafe_base64
      unless UserAuth.where(:conf_token => token).any?
        self.conf_token = token
        self.confirm_sent_at = Time.now.utc
      end
    end
  end
end