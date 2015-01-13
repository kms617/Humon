require 'rails_helper'

describe 'GET/v1/events/:id' do
  it 'returns an event by :id' do
    event = FactoryGirl.create(:event)

    get v1_event_path(id: event.id)

    expect(response_json).to eq(
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
    )
  end
end

describe 'POST/v1/events' do
  it 'saves the address, lat, lon, name, and started_at date' do
    event = build :event
    event_params = {
      address: event.address,
      ended_at: event.ended_at,
      lat: event.lat,
      lon: event.lon,
      name: event.name,
      started_at: event.started_at,
      owner: {
        device_token: event.owner.device_token
      }
    }
    post v1_events_path,
          { event: event_params }.to_json,
          'Content-Type' => 'application/json'

    response_event = Event.last
    expect(response_json).to eq('id' => response_event.id)
    expect(response_event.address).to eq event.address
    expect(response_event.ended_at.to_i).to eq event.ended_at.to_i
    expect(response_event.lat).to eq event.lat
    expect(response_event.lon). to eq event.lon
    expect(response_event.name).to eq event.name
    expect(response_event.started_at.to_i).to eq event.started_at.to_i
    expect(response_event.owner).to eq event.owner
  end

  it 'returns an error message when invalid' do
    empty_params = {
      address: nil,
      ended_at: nil,
      lat: nil,
      lon: nil,
      name: nil,
      started_at: nil,
      owner: {
        device_token: nil
      }
    }

    post v1_events_path,
          { event: empty_params }.to_json,
          'Content-Type' => 'application/json'

    expect(response_json). to eq(
      'message' => 'Validation Failed',
      'errors' => [
        "Lat can't be blank",
        "Lon can't be blank",
        "Name can't be blank",
        "Started at can't be blank"
      ]
    )
    expect(response).to have_http_status :unprocessable_entity
  end
end

describe 'PATCH /v1/events/:id' do
  it 'updates the event attributes' do
    event = create(:event, name: 'Old name')
    new_name = 'New name'
    event_params = {
      name: new_name,
      owner: {
        device_token: event.owner.device_token
      },
    }

    patch v1_event_path(id: event.id),
          { event: event_params }.to_json,
          'Content-Type' => 'application/json'

    event.reload
    expect(event.name).to eq new_name
    expect(response_json).to eq('id' => event.id)
    expect(response).to have_http_status :ok
  end

  it 'returns an error message when invalid' do
    event = create(:event)
    bad_event_params = {
      name: nil,
      owner: {
        device_token: event.owner.device_token
      },
    }

    patch v1_event_path(id: event.id),
          { event: bad_event_params }.to_json,
          'Content-Type' => 'application/json'

    event.reload
    expect(event.name).to be
    expect(response_json).to eq(
      'message' => 'Validation Failed',
      'errors' => [
        "Name can't be blank"
      ]
    )
    expect(response).to have_http_status :unprocessable_entity
  end
end
