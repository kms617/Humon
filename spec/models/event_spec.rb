require 'rails_helper'

RSpec.describe Event, model: true do
  it { should belong_to(:owner) }

  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lon) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:started_at) }

end
