class PostsController < ApplicationController
	before_action :authenticate_user!
	# before_action :set_post

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def edit
	end

	def show
		@post = Post.find(params[:id])

	end

	def create
		@post = Post.new(post_params)


		if @post.save
			redirect_to root_path, notice: "New Event created!"
		else
			render :new
		end
	end

	def update
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		respond_to do |format|
			format.html { redirect_to root_path, alert: "Event deleted." }
			format.js { render nothing: true }
		end

	end
 
private

def post_params
	params.require(:post).permit(:body , :event_type , :location).merge(user: current_user)
end

def set_post
	@post = Post.find(params[:id])
end



end