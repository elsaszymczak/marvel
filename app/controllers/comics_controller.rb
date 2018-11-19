class ComicsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_comic, only: [:show, :destroy]

  def index
    @comics = Comic.all
  end

  def show
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
    params.require(:comic).permit(:name, :picture)
  end

  def set_comic
    @comic = Comic.find(params[:id])
  end
end
