class AlbumsController < ApplicationController
  respond_to :html, :json

  def index
    @albums = Album.page(params[:page]).per(30)
  end

  def show
    @album = Album.find_by_id(params[:id])
    @photos = @album.photos.page(params[:photos_page]).per(12)
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
    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, :flash => { :success => "Album Updated Successfully" }}
        format.json { respond_with_bip(@album) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@album) }
      end
    end
  end

  def destroy
    Album.find_by_id(params[:id]).destroy
    flash[:success] = "Album Destroyed"
    redirect_to albums_path
  end
end 
