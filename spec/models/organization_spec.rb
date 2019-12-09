require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should validate_presence_of :title }
  it { should have_many(:users) }
end
