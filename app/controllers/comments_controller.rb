class CommentsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment].permit(:comment))
		@comment.user_id = current_user.id if current_user
		@comment.save

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end


	def edit	

		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def update 

		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		if @comment.update(params[:comment].permit(:comment))
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end


	def destroy

		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	def upvote
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])	
		@comment.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.downvote_by current_user
		redirect_to :back
	end




end