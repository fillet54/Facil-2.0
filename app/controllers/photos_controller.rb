class PhotosController < ApplicationController

  def new
    @album = Album.find_by_id(params[:album_id])
    @photo = @album.photos.build
  end

  def create
    @album = Album.find_by_id(params[:photo][:album_id])
    params[:photo].delete(:album_id)
    @photo = @album.photos.build(params[:photo])
    if @photo.save
      redirect_to @photo.album
    else
      render action: 'new'
    end
  end

  def show
    @photo = Photo.find_by_id(params[:id])
  end

  def destroy
     photo = Photo.find_by_id(params[:id])
     album = Album.find_by_id(photo.album_id)
     photo.destroy
     flash[:success] = "Photo Destroyed"
     redirect_to album_path(album)
  end
end
