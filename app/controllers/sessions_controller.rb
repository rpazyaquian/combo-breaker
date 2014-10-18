class SessionsController < ApplicationController
  def new
    # show the sign in page
  end

  def create
    # check to see if there is a user matching
    # the information sent via params
    # set the session's :user_id parameter to the user's id
    # and redirect to root

    # thx to michael hartl for the review on how to do this
    user = User.find_by(email: session_params[:email].downcase)
    # if the user exists AND
    # the user's authenticated when given the password
    if user && user.authenticate(session_params[:password])
      login_user(user)
    else
      # no match, display the sign in page again
      # (think of errors to pass!)
      render 'new'
    end
  end

  def destroy
    # set the sessions :user_id parameter to nil
    # and redirect to root
    logout_user(current_user)
    redirect_to root_path
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end

    def login_user(user)
      session[:user_id] = user.id
    end

    def logout_user(user)
    end
end
