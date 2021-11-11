class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
    if @user.update(user_params)
       redirect_to user_path(@user)
    else 
      render :edit
    end
  end
  
  def update
    
  end
end
