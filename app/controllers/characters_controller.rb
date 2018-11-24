class CharactersController < ApplicationController
    before_action :set_character, only: [:show, :destroy]

  def index
    @characters = Character.all.order(created_at: :desc)
  end

  def show
    @characters = Character.all
    @event = @character.event
  end


  def new
    @event = Event.find(params[:event_id])
    @character = Character.new
  end

  def create
    @event = Event.find(params[:event_id])
    @character = Character.new(character_params)
    @character.event = @event
    if @character.save
       @character.reload
      respond_to do |format|
        format.html { redirect_to event_path(@event) }
        format.js  { render layout: false, content_type: 'text/javascript' } # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'events/show' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @character.destroy
  end

  private

  def character_params
    params.require(:character).permit(:name, :photo)
  end

  def set_character
    @character = Character.find(params[:id])
  end

end
