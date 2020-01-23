# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

organization_title_list = %w[Readworms Anonymus MemeCult History]
organization_title_list.each do |title|
  Organization.create(title: title)
end

Organization.create(title: 'Georgians')

ActiveRecord::Base.transaction do
  user_name_list = %w[Peter Greg Alice Clara]
  user_name_list.each do |name|
    User.create!(name: name, active: true, organization_id: 1)
  end

  user_name_list = %w[Gregor JD Boris]
  user_name_list.each do |name|
    u = User.create!(name: name, active: false, organization_id: 2)
    puts u.errors.full_messages
  end

  user_name_list = %w[Samuel Lora John]
  user_name_list.each do |name|
    User.create!(name: name, active: true, organization_id: 3)
  end

850.times do
  User.all.each do |user|
    line = Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    Post.create(content: line, status: :active, user_id: user.id)
  end
  User.all.each do |user|
    line = Faker::Movies::StarWars.quote
    Post.create(content: line, status: :active, user_id: user.id)
  end
  User.all.each do |user|
    line = Faker::Movies::StarWars.wookiee_sentence
    Post.create(content: line, status: :inactive, user_id: user.id)
  end

  User.all.each do |user|
    line = Faker::Movies::Lebowski.quote
    Post.create(content: line, status: :archived, user_id: user.id)
  end
  User.all.each do |user|
    line = Faker::TvShows::DrWho.quote
    Post.create(content: line, status: :under_review, user_id: user.id)
  end

  User.all.each do |user|
    line = Faker::Books::Lovecraft.paragraph
    Post.create(content: line, status: :active, user_id: user.id)
  end
end

