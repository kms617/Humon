require 'rails_helper'

describe Event do
  describe 'associations' do
    it { should belong_to(:owner) }
  end

  describe 'validations' do
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:started_at) }
  end

end
