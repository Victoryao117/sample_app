class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end
  def create
    #@user = User.new(params[:user]) # Not the final implementation!
    #上述方法不安全，以为未定义Hash（params[:user]）中的内容，故需要一个辅助方法（user_params）来进行加固
    @user = User.new(user_params)
    if @user.save
      #用户创建后直接登录
      sign_in @user

      redirect_to @user
      flash[:success] = "Welcome to the Sample App!"
		  # Handle a successful save.
	  else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  #定义了一个健壮参数
  #private 以下的所有方法均为私有，故不可把公有方法放在下面。
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
  
  
end
