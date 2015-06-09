class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :close, :password, :follow, :unfollow, :profile]

  def profile
    @user = current_user
    @post = @user.posts.all
    render :show

  end

  def close
  end

  def password
  	@user = current_user
  end

  def new
  	@user = User.new
  end

  def edit
  	@user = current_user
  end

  def show
    @user = User.find_by_username(params[:username])
     @post = @user.posts.all
    
  end

  def follow
    @relationship = Relationship.new(follower_id: current_user.id, followed_id: params[:id])
    @user = User.find(params[:id])
    if @relationship.save
      flash[:notice] = "You've successfully followed #{@user.username}."
    else
      flash[:alert] = "There was an error following that user."
    end
    redirect_to username_path(@user.username)
  end

  def unfollow
    @relationship = Relationship.find_by(follower_id: current_user.id, followed_id: params[:id])
    @user = User.find(params[:id])
    if @relationship and @relationship.destroy
      flash[:notice] = "You've successfully unfollowed #{@user.username}."
    else
      flash[:alert] = "There was an error unfollowing that user."
    end
    redirect_to username_path(@user.username)
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to username_path(@user.username), notice: "New account created!"
  	else
  		render :new
  	end
  end

  def update
  	@user = current_user
  	old_password = params[:user][:current_password]
  	if old_password
  		if old_password == current_user.password
  			if @user.update(user_params.except(:current_password))
  				redirect_to username_path(@user.username), notice: "Password updated."
  			else
  				render :password
  			end
  		else
  			flash[:alert] = "Wrong password"
  			render :password
  		end
  	elsif @user.update(user_params)
  		redirect_to username_path(@user.username), notice: "Profile updated."
  	else
  		render :edit
  	end
  end

  def destroy
  	@user = current_user
  	if @user.password == params[:user][:password]
  		@user.destroy
  		session[:user_id] = nil
  		redirect_to root_path, notice: "Your account has been deleted."
  	else
  		flash[:alert] = "Wrong password. Having second thoughts?"
  		render :close
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:username, :email, :lname, :fname, :password, :password_confirmation, :current_password, :image)
  end

end
