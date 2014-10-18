class SessionsController < ApplicationController
  def new
    # show the sign in page
  end

  def create
    # thx to michael hartl for the review on how to do this
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      binding.pry
      redirect_to root_path
    else
      # (think of errors to pass!)
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end

end
