class CharactersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end
end
