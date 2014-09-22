class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :correct_admin_user, only: [:index, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
   # @user = User.find(params[:id]) not needed due to :correct user before action
  end



  # POST /users
  # POST /users.json
   def create
    @user = User.new(user_params)

 
      if @user.save
        flash[:success] = "Welcome to the Blog App!"
        sign_in @user
        redirect_to @user #notice: 'User was successfully created.' 
    #    format.json { render action: 'show', status: :created, location: @user }
      else
        render action: 'new'
      #  format.json { render json: @user.errors, status: :unprocessable_entity }
      end

  end

  # # PATCH/PUT /users/1
  # # PATCH/PUT /users/1.json
  def update
     #@user = User.find(params[:id])  not needed due to :correct user before action
     if (@user.update_attributes(user_params))
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # # DELETE /users/1
  # # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = User.find(params[:id])
    # end

     # Never trust parameters from the scary internet, only allow the white list through.
     def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation)
     end

    

     def correct_user
        @user = User.find(params[:id])
        redirect_to root_url, notice: "Invalid User!" unless current_user?(@user)
     end

    
end
