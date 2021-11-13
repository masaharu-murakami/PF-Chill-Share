class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
       redirect_to user_path
    else
      render :edit
    end
  end

  def confirm
    @user = current_user
  end

  def quit
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

private
  def user_params
    params.required(:user).permit(:nickname, :profile_image)
  end
end
