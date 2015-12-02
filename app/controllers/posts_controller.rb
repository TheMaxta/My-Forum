class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	#this above line is just so we can write this out faster..
	#the above methods will use the find_post method, so this just helps it happen faster

	def index 
		@posts = Post.all.order("created_at DESC")
	end


	def show 
	end
	def new 
		@post = current_user.posts.build

	end

	def create
		@post = current_user.posts.build(post_params)

			if @post.save
				redirect_to @post
			else
				render 'new'
			end
	end
	def edit
		unless current_user == @post.user
   		redirect_to(@post, notice: "You cannot edit this post") and return
		end
	end


	def update
		unless current_user == @post.user
   		redirect_to(@post, notice: "You cannot edit this post") and return
		end
		if @post.update(post_params)
			redirect_to @post
		else 
			render 'edit'
		end


	end
	def delete
		unless current_user == @post.user
   		redirect_to(@post, notice: "You cannot edit this post") and return
		end
	end
	
	def destroy
		unless current_user == @post.user
   		redirect_to(@post, notice: "You cannot edit this post") and return
		end
		@post.destroy
		redirect_to root_path
	end

 private

 	def find_post
		@post = Post.find(params[:id])

 	end

	def post_params
		params.require(:post).permit(:title, :content)

	end
end
