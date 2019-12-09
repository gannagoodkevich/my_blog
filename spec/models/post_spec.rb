require 'rails_helper'

RSpec.describe Post, type: :model do

  it { should validate_presence_of :content }
  it { should validate_presence_of :user_id }
  it { should belong_to(:user) }
  it { should have_many(:images) }


  describe 'creation' do
    let(:content_invalid) {
      "It is said that they live in “cnocs” (hollow hills, in Irish), which are located in the “sidhe”.',
                   'The “sidhe” are mounds where megalithic monuments are erected in many places on the island.',
                   'There the fairies are ruled by a king or queen.',
                   'For the Irish, the butterflies are a message of the fairies, a sign of metamorphosis of the spirits waiting to be reborn.',
                   'Likewise, they represent journeys between worlds in search of knowledge.',
                   'Reading Bulgakov’s satire of 1930s Stalinist Moscow helped me to see just how easy it is to mess up a nation psychologically.',
                   'In the novel the devil and his retinue (which includes a wall-eyed loon and a talking cat) manipulate “the Master”, a writer, and Margarita, his muse.',
                   'Simultaneously – because the narrative flits between two stories – Pontius Pilate condemns Christ to death in Jerusalem. ',
                   'The Active Record way claims that intelligence belongs in your models, not in the database. As such, features such as triggers or constraints, which push some of that intelligence back into the database, are not heavily used.',
                   'AYou could have my favourite face" }
    let(:content_valid) { 'Hello? World!' }
    it 'content is not valid' do
      post = Post.create(content: content_invalid)
      expect(post).to be_invalid
    end

    it 'content is not valid' do
      post = Post.create(content: content_valid)
      expect(post).to be_invalid
    end

    it 'content is not valid' do
      post = Post.create(content: content_valid, user_id: 2)
      expect(post).to be_valid
    end
  end

  describe 'writting to DB' do
    let(:content_valid) { 'Hello, World!' }
    before do
      @post = Post.create(content: content_valid, user_id: 2)
      puts @post.id
    end

    it 'content is written' do
      expect(@post.content).to include('Hello, World!')
    end

    it 'Post is written to DB' do
      expect(Post.first).to eql(@post)
    end
  end
end
