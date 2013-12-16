class UsersController < ApplicationController
  # invoking signed_in_user method.
  # Filter acts only on edit and update.
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page]) # Key: page, value is page
    # 30 is the default number of users pulled out.
  end

  def show
  	@user = User.find(params[:id]) # params used to retrieve user id.
  end

  def new
  	@user = User.new
  end

  def create
    # params contains a hash of hashes (user attributes)
    # params[:user] is basically name: "Foo Bar", email: "foo@invalid", password: "foo", password_confirmation: "bar"
    # params[:user] passes all the submitted user data to User.new() which is unsafe
    @user = User.new(user_params)  # auxillary method user_params
    if @user.save
        sign_in @user
        flash[:success] = "Get Ready to Hate a Software!"
        redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  # Only admins can destroy as written in _user.html.erb
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters 
    def signed_in_user
      unless signed_in?
        store_location
      redirect_to signin_url, notice: "Please sign in."
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
end