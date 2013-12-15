class UsersController < ApplicationController
  
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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
