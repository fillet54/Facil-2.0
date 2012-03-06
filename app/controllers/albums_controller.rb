class AlbumsController < ApplicationController

  def index
    @albums = Album.paginate(page: params[:page])
  end
end 
