class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(name: params[:session][:name])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to posts_home_path
		else
			flash.now[:error] = 'Invalid username/password combination'
			render 'new'
			# create error
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

end
