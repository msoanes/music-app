class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]
  before_action :require_login, only: :destroy

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(*user_params.values)
    if @user
      login_user!
      redirect_to user_url(@user)
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Invalid email or password"]
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end
end
