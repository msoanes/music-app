class NotesController < ApplicationController
  def create
    @note = Note.new(
      notes: params[:note][:notes],
      track_id: params[:note][:track_id],
      user_id: current_user.id
    )
    if @note.save
      flash[:success] = "This page has been blessed with your insight."
    end
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:success] = "You showed them."
    redirect_to track_url(@note.track_id)
  end
end
