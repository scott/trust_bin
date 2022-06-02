class Admin::UsersController < ApplicationController
  before_action :is_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find_by(uuid: params[:uuid])
  end

  def new
    @user = User.new
  end

  def update
    @user = User.find_by(uuid: params[:uuid])
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end    
  end

  def create
    @user = User.new(user_params)
    @user.uuid = SecureRandom.uuid
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    
    @user = User.find_by(uuid: params[:uuid])
    @user.destroy
    redirect_to admin_users_path
  end

  def is_admin
    return if current_user.role == 'admin' 
    redirect_to root_path
  end

  private 

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :role,
      :email,
      :password,
      :password_confirmation
    )
  end
  

end
