# User Comtroller
class UsersController < ApplicationController
  before_filter :require_login, only: [:index]

  def new
    @user = User.new
    respond_to do |format|
      format.js {}
      format.html
    end
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])
    respond_to do |format|
      format.json { render json: !@user }
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path, success: 'Signed up!'
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
