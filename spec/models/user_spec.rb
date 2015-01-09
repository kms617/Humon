require 'rails_helper'

RSpec.describe User, model: true do
  it { should have_many(:events) }

  it { should validate_presence_of(:device_token) }  
end
