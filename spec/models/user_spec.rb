require 'rails_helper'

describe User do
  describe 'associations' do
    it { should have_many(:events) }
  end
end
