class AlbumsController < ApplicationController

  def index
    @albums = Album.paginate(page: params[:page])
  end

  def show
    @album = Album.find_by_id(params[:id])
    @photos = @album.photos.paginate(page: params[:photos_page])
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    if @album.save
      redirect_to albums_path
    else
      render 'new'
    end
  end
end 
