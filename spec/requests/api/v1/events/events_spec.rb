require 'rails_helper'

describe 'GET/v1/events/:id' do
  it 'returns an event by :id' do
    event = FactoryGirl.create(:event)

    get v1_event_path(id: event.id)

    expect(response).to match_response_schema(:event)
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
    expect(response).to match_response_schema(:event)
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
      "errors" =>
      "Validation failed: Address can't be blank, "\
      "Lat can't be blank, Lon can't be blank, "\
      "Name can't be blank, Started at can't be blank"
    )
    expect(response).to have_http_status :bad_request
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
    expect(response).to match_response_schema(:event)
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
    expect(response_json).to eq( "errors"=>"Validation failed: Name can't be blank" )
    expect(response).to have_http_status :bad_request
  end
end
