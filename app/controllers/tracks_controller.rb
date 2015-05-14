class TracksController < ApplicationController
  before_action :require_login

  def show
    @track = Track.find(params[:id])
  end

  def new
    @albums = Album.all
    @track = Track.new(album_id: params[:album_id].to_i)
  end

  def create
    @albums = Album.all
    @track = Track.new(track_params)
    if @track.save
      flash[:success] = "Sweet as."
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @albums = Album.all
    @track = Track.find(params[:id])
  end

  def update
    @albums = Album.all
    @track = Track.find(params[:id])
    if @track.update(track_params)
      flash[:success] = "Whatta GC"
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    flash[:success] = "Destruction is the universal art form"
    redirect_to album_url(@track.album_id)
  end

  private

  def track_params
    params.require(:track).permit(:title, :name, :is_bonus, :album_id, :lyrics)
  end
end
