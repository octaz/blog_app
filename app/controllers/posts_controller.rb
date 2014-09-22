class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_admin_user, only: [:edit, :update, :new, :destroy, :create]


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  def home
    #to do, implement search by
     if params[:tag]
       @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page])
     #  @posts = Post.tagged_with_paginate(params[:tag], params[:page])
     else
      @posts = Post.paginate(page: params[:page])
     end
  end

 

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.update_attribute(:user_id, current_user.id)

      if @post.save
       flash[:success] = "Post Created"
       redirect_to home_path
     
      else
        render action: 'new' 
       
      end
    
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
 
      if @post.update_attributes(post_params)
        flash[:success] = "Post Updated"
        redirect_to home_path
        
      else
        render action: 'edit' 
       
      end
   
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post deleted."
    redirect_to home_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :tag_list)
    end




    

    
end
