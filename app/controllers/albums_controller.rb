class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
  end

  def new
    @bands = Band.all
    @album = Album.new
    @band_id = params[:band_id].to_i
  end

  def create
    @bands = Band.all
    @album = Album.new(album_params)
    @band_id = @album.band_id
    if @album.save
      flash[:success] = "The kickass band has a kickass album!"
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    @band_id = @album.band_id
    render :edit
  end

  def update
    @bands = Band.all
    @album = Album.find(params[:id])
    @band_id = @album.band_id
    if @album.update(album_params)
      flash[:success] = "Did that album just get a little more awesome?"
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:success] = "This album was more beautiful than the world deserved"
    redirect_to band_url(@album.band_id)
  end

  private

  def album_params
    params.require(:album).permit(:title, :recording_type, :band_id)
  end
end
