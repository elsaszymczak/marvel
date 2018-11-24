class ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :destroy]

  def index
    @comics = Comic.all.order(created_at: :asc)
  end

  def show
    @comics = Comic.all
    @event = @comic.event
  end

  def new
    @comic = Comic.new
    @event = Event.find(params[:event_id])
  end

  def create
    @comic = Comic.new(comic_params)
    @event = Event.find(params[:event_id])
    @comic.event = @event
    if @comic.save
      @comic.reload
      respond_to do |format|
        format.html { redirect_to event_path(@event) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'events/show' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @comic.destroy
  end

  private

  def comic_params
    params.require(:comic).permit(:name, :photo)
  end

  def set_comic
    @comic = Comic.find(params[:id])
  end
end
