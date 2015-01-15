require 'rails_helper'

describe User do
  describe 'associations' do
    it { should have_many(:events) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of (:password_digest) }
  end

end
