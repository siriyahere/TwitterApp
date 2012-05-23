class UsersController < ApplicationController
  
   before_filter :authenticate, :only => [:index, :edit, :update ,:destroy]
   before_filter :correct_user, :only => [:edit, :update]
   before_filter :admin_user, :only => :destroy
  def index
    @title= "All Users"
    @users = User.paginate(:page => params[:page])
  end
  def show
  	@user = User.find(params[:id])
  	@microposts = @user.microposts.paginate(:page => params[:page])
    @title= @user.name
  end
  
  def new 
  	@user =User.new
  	@title ="Sign Up"
  end
  def create
  # raise params[:user].inspect
   @user=User.new(params[:user])
  if @user.save
     redirect_to @user, :flash=> {:success => "Welcome to the sample App" }
  	 
  	else
   @title= "Sign up"
   render 'new'
  end
 end 
 def edit
  #raise request.inspect
  @user = User.find(params[:id])
  @title ="Edit User"
 end
 def update
  
  @user = User.find(params[:id])
  if @user.update_attributes(params[:user])
   redirect_to @user, :flash=> {:success => "Profile Updated" }
  else
  @title= "Edit User"
  render edit
  end
 end
def destroy
  raise params.inspect
#User.find_by_name(:name).destroy
User.find(params[:id]).destroy
#@user.destroy
 flash[:success] = "User destroyed"
 redirect_to users_path
end
private
  def authenticate
      deny_access unless signed_in?
  end
  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  def admin_user
     user=User.find(params[:id])
    redirect_to(root_path) unless ( current_user.admin? && !current_user?(user))
  end
  def deny_access
      session[:return_to]=request.fullpath
      flash[:notice] = "Please sign in to access this page."
      redirect_to signin_path 
  end
end