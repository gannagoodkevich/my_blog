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

posts_content = ['It is said that they live in “cnocs” (hollow hills, in Irish), which are located in the “sidhe”.',
                 'The “sidhe” are mounds where megalithic monuments are erected in many places on the island.',
                 'There the fairies are ruled by a king or queen.',
                 'For the Irish, the butterflies are a message of the fairies, a sign of metamorphosis of the spirits waiting to be reborn.',
                 'Likewise, they represent journeys between worlds in search of knowledge.',
                 'Reading Bulgakov’s satire of 1930s Stalinist Moscow helped me to see just how easy it is to mess up a nation psychologically.',
                 'In the novel the devil and his retinue (which includes a wall-eyed loon and a talking cat) manipulate “the Master”, a writer, and Margarita, his muse.',
                 'Simultaneously – because the narrative flits between two stories – Pontius Pilate condemns Christ to death in Jerusalem. ',
                 'The Active Record way claims that intelligence belongs in your models, not in the database. As such, features such as triggers or constraints, which push some of that intelligence back into the database, are not heavily used.',
                 'AYou could have my favourite face']
i = 1
posts_content.each do |post|
  Post.create(content: post, status: :active, user_id: i)
  i += 1
end

Post.create(content: "MyPost", status: 'archived', user_id: 1)

