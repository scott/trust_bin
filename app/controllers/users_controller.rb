class UsersController < ApplicationController
  before_action :is_admin?

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
    @user = Scrubber.find(params[:uuid])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end    
  end

  def create
  end

  def destroy
  end

  private 

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :role,
      :email,
      :password
    )
  end
  
  def is_admin?
    current_user.role == 'admin'
  end
end
