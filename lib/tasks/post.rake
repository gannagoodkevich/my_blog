namespace :post do
  desc "Add data about Georgians"
  task post_task: :environment do
    Organization.create(title: "Georgians")
    user_name_list = %w[Pipin Frodo Gendalf]
    user_name_list.each do |name|
      User.create(name: name, active: true, organization_id: Organization.find_by(title: "Georgians").id)
      puts Organization.find_by(title: "Georgians")
    end
    posts_content = ["This is the irst Frodo's post", "This is the second"]
    posts_content.each do |post|
      Post.create(content: post, status: :active, user_id: User.find_by(name: "Pipin").id)
    end
  end

end
