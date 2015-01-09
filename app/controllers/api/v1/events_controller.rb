class Api::V1::EventsController < ApiController
  def show
    @event = Event.find(params[:id])
  end

  def create
  end
end
