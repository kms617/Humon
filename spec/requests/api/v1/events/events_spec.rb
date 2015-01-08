require 'rails_helper'

describe 'GET/v1/events/:id' do
  it 'returns an event by :id' do
    event = FactoryGirl.create(:event)

    get "/v1/events/#{event.id}"

    expect(response_json).to eq(
      {
        'address' => event.address,
        'created_at' => event.created_at.as_json,
        'ended_at' => event.ended_at.as_json,
        'id' => event.id,
        'lat' => event.lat,
        'lon' => event.lon,
        'name' => event.name,
        'started_at' => event.started_at.as_json,
        'updated_at' => event.updated_at.as_json,
        'owner' => {
          'created_at' => event.owner.created_at.as_json,
          'device_token' => event.owner.device_token,
          'updated_at' => event.owner.updated_at.as_json
        }
      }
    )
  end
end
