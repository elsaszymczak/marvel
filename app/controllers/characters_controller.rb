class CharactersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
    before_action :set_character, only: [:show, :destroy]

  def index
    @characters = Character.all
  end

  def show
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
    params.require(:character).permit(:name, :picture)
  end

  def set_character
    @character = Character.find(params[:id])
  end

end
