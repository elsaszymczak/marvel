class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy]

  def index
    @events = Event.all
  end

  def show
    @character = Character.new
    @comic = Comic.new
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      @event.reload
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'pages/home' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :photo, :wiki_link)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
