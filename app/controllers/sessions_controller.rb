class SessionsController < ApplicationController
	
	def new 
	end

	# inside this action, user authentication information 
	# is present
	def create
		# pulls user from the DB by email.
		user = User.find_by(email: params[:session][:email].downcase)
		  if user && user.authenticate(params[:session][:password]) #3 possible results with this logic
		    # Sign the user in and redirect to the user's show page.
		    sign_in user #sign_in function
		    redirect_back_or user # redict to requested URL if it exists or to some default URL
		  else
		    # Create an error message and re-render the signin form.
		    # flash.now is used to display flash messages on rendered pages
		    flash.now[:error] = 'Invalid email/password combination'
      		render 'new'
		  end
	end
	
	def destroy
    sign_out
    redirect_to root_url
  end
end
