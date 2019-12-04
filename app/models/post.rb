class Post < ApplicationRecord
  has_one :user
  enum status: %i[inactive under_review active archived]

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
