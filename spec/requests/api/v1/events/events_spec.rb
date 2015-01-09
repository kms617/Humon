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

describe 'POST/v1/events' do
  it 'saves the address, lat, lon, name, and started_at date' do
    date = Time.zone.now
    device_token = '123abcd456xyz'
    owner = create(:user, device_token: device_token)

    post '/v1/events', {
      address: '123 Example St.',
      ended_at: date,
      lat: 1.0,
      lon: 1.0,
      name: 'Fun Place!!',
      started_at: date,
      owner: {
        device_token: device_token
      }
    }.to_json, { 'Content-Type' => 'application/json' }

    event = Event.last
    expect(response_json).to eq({ 'id' => event.id} )
    expect(event.address).to eq '123 Example St.'
    expect(event.ended_at.to_i).to eq date.to_i
    expect(event.lat).to eq 1.0
    expect(event.lon). to eq 1.0
    expect(event.name).to eq 'Fun Place!!'
    expect(event.started_at.to_i).to eq date.to_i
    expect(event.owner).to eq owner
  end

  it 'returns an error message when invalid', focus: true do
    post '/v1/events',
      { address: nil,
        ended_at: nil,
        lat: nil,
        lon: nil,
        name: nil,
        started_at: nil,
        owner: {
          device_token: nil
          }
          }.to_json, { 'Content-Type' => 'application/json' }

    event = Event.last
    expect(response_json). to eq({
      'message' => 'Validation Failed',
      'errors' => [
        "Lat can't be blank",
        "Lon can't be blank",
        "Name can't be blank",
        "Started at can't be blank"
      ]
    })
    expect(response.code.to_i).to eq 422
  end
end
