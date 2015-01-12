describe 'GET /v1/events/nearests?lat=&lon=&radius=' do
  it 'returns the events closest to the lat and lon' do
    near_event = create(:event, lat: 37.76032, lon: -122.42966)
    farther_event = create(:event, lat: 37.76031, lon: -122.42966)
    create(:event, lat: 37.68773, lon: -122.47061)
    lat = 37.77109
    lon = -122.43078
    radius = 5

    get "/v1/events/nearests?lat=#{lat}&lon=#{lon}&radius=#{radius}"

    expect(response_json).to eq([
    {
      'address' => near_event.address,
      'ended_at' => near_event.ended_at,
      'id' => near_event.id,
      'lat' => near_event.lat,
      'lon' => near_event.lon,
      'name' => near_event.name,
      'owner' => {
        device_token: near_event.owner.device_token
      }
      # 'started_at' => near_event.started_at.as_json
    },
    {
      'address' => farther_event.address,
      'ended_at' => farther_event.ended_at,
      'id' => farther_event.id,
      'lat' => farther_event.lat,
      'lon' => farther_event.lon,
      'name' => farther_event.name,
      'owner' => {
        device_token: farther_event.owner.device_token
        }
      # 'started_at' => farther_event.started_at.as_json
      }
    ])
  end
end
