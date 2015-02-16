class CommentsController < ApplicationController
	require 'will_paginate/array'

	
	def index
		@post = Post.find(params[:post_id])
		@comments = @post.comments.paginate(page: params[:page], per_page: 10)
		@comment = Comment.new
	end

	def destroy
	    @post = Post.find(params[:post_id])
	    @comment = @post.comments.find(params[:id])
	    @comment.destroy
	    redirect_to post_path(@post)
	end

	def show
	  
	end

	def edit
		@comment = Comment.find(params[:id])
	end


	def new
		@post = Post.find(params[:post_id])
		@comment = Comment.new
	end


	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)

		#@post = Post.find(params[:post])
		#@post = Post.find(params[:post_id])
		#@comment = Comment.new(comment_params)
		#@comment.update_attribute(:post, @post)
		#@comment.update_attributes(:post, @post)
		if (current_user!=nil)
			@comment.update_attribute(:user, current_user)
		end

		if @comment.save
			flash[:success] = "Comment Created"
			redirect_to post_comments_path(@comment.post)
		else
			render action: 'new'
		end
	end

	def destroy

	end

	def update

	end



	private 

		def set_comment
			@comment = Comment.find(params[:id])
		end

		def comment_params
			params.require(:comment).permit(:content, :user, :author, :post)
		end

end
