class ComicsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @comics = Comic.all
  end

  def show
    @comic = Comic.find(params[:id])
  end
end
