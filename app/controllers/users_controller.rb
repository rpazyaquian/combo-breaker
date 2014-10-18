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
  end

  def update
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
