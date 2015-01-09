require 'rails_helper'

RSpec.describe User, model: true do
  it { should have_many(:events) }
end
