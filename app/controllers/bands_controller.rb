class BandsController < ApplicationController
  before_action :require_login

  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:success] = "You have created your cool new band"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      flash[:success] = "Your cool band is, hopefully, even cooler"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    flash[:success] = "Your band is so cool it has sublimated into the aether"
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
