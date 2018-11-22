class CharactersController < ApplicationController
    before_action :set_character, only: [:show, :destroy]

  def index
    @characters = Character.all
  end

  def show
    @characters = Character.all
    @event = @character.event
  end


  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      redirect_to character_path(@character)
    else
      render :new
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
