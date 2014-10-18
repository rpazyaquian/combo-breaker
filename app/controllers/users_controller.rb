class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.save
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def edit
    if signed_in?
      @user = current_user
    else
      redirect_to root_path
    end
  end

  def update
    @user = params[:id]
    @user.update(user_params)
    redirect_to root_path
  end

  def destroy
    # nothin yet
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
