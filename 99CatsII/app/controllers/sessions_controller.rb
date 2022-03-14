class SessionsController < ApplicationController

  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: [:destroy]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    @user.reset_session_token!
    session[:session_token] = @user.session_token
    redirect_to cats_url
  end

  def destroy
    @user = current_user
    @user.reset_session_token!
    session[:session_token] = nil
  end
end
