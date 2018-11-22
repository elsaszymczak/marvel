class ComicsController < ApplicationController
  before_action :set_comic, only: [:show, :destroy]

  def index
    @comics = Comic.all
  end

  def show
    @comics = Comic.all
    @event = @comic.event
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    if @comic.save
      redirect_to comic_path(@comic)
    else
      render :new
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
