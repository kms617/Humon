describe 'GET /v1/events/nearests?lat=&lon=&radius=' do
  it 'returns the events closest to the lat and lon' do
    near_event = create(:event, :museum)
    farther_event = create(:event, :cambridge)
    intrepid = build(:event, :intrepid)
    lat = intrepid.lat
    lon = intrepid.lon
    radius = 5

    get v1_events_nearests_path(lat: lat, lon: lon, radius: radius)

    expect(response).to match_response_schema(:nearest)
  end

  it 'returns an error message when no event is found' do
    chicago = build(:event, :chicago)
    lat = chicago.lat
    lon = chicago.lon
    radius = 5

    get v1_events_nearests_path(lat: lat, lon: lon, radius: radius)
    expect(response_json). to eq(
      'message' => 'No Events Found',
    )
    expect(response).to have_http_status :ok
  end
end
