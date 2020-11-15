class SessionsController < ApplicationController 

  def create 
    user=User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id]=user.id
      flash[:notice]="Log in succesfully"
      redirect_to user
    else
      flash.now[:alert]="Somethings wrong!"
      render 'new'
    end

  end

  def new 

  end

  def destroy 
    session[:user_id] = nil
    flash[:notice]="Logged out . See you soon !"
    redirect_to root_path
  end

end