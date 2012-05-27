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
      flash[:success] = "Album was created successfully"
      redirect_to albums_path
    else
      render action: 'new'
    end
  end

  def edit
    @album = Album.find_by_id(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(params[:album])
      flash[:success] = "Album Updated Successfully"
      redirect_to @album
    else
      render 'edit'
    end
  end
end 
