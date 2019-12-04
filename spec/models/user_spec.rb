require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :name }
  it { should validate_inclusion_of(:active).in_array([true, false])}
  it { should have_many(:posts) }
  it { should have_many(:images) }
end
