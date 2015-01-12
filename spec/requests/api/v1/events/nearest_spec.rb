describe 'GET /v1/events/nearests?lat=&lon=&radius=' do
  it 'returns the events closest to the lat and lon' do
    near_event = create(:event, :museum)
    farther_event = create(:event, :cambridge)
    farthest_event = create(:event, :new_york)
    intrepid = build(:event, :intrepid)
    lat = intrepid.lat
    lon = intrepid.lon
    radius = 5

    get "/v1/events/nearests?lat=#{lat}&lon=#{lon}&radius=#{radius}"

    expect(response_json).to eq([
    {
      'address' => near_event.address,
      'created_at' => near_event.created_at.as_json,
      'ended_at' => near_event.ended_at,
      'id' => near_event.id,
      'lat' => near_event.lat,
      'lon' => near_event.lon,
      'name' => near_event.name,
      'started_at' => near_event.started_at.as_json,
      'updated_at' => near_event.updated_at.as_json,
      'owner' => {
        'created_at' => near_event.created_at.as_json,
        'device_token' => near_event.owner.device_token,
        'updated_at' => near_event.updated_at.as_json
      },
    },
    {
      'address' => farther_event.address,
      'created_at' => farther_event.created_at.as_json,
      'ended_at' => farther_event.ended_at.as_json,
      'id' => farther_event.id,
      'lat' => farther_event.lat,
      'lon' => farther_event.lon,
      'name' => farther_event.name,
      'started_at' => farther_event.started_at.as_json,
      'updated_at' => farther_event.updated_at.as_json,
      'owner' => {
        'created_at' => farther_event.created_at.as_json,
        'device_token' => farther_event.owner.device_token,
        'updated_at' => farther_event.updated_at.as_json
      },
      }
    ])
  end

  it 'returns an error message when no event is found' do
    chicago = build(:event, :chicago)
    lat = chicago.lat
    lon = chicago.lon
    radius = 5

    get "/v1/events/nearests?lat=#{lat}&lon=#{lon}&radius=#{radius}"

    expect(response_json). to eq({
      'message' => 'No Events Found',
      })
      expect(response).to have_http_status :ok
  end
end
