class UsersController < ApplicationController
  before_action :set_user,only: [:edit,:update,:show,:destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin,only: [:destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

        if @user.save
            session[:user_id]= @user.id
            flash[:success] = "Hey #{@user.username}, welcome"
             redirect_to user_path(@user)
        else
            render 'new'
        end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      flash[:success] = "Account was updated successfully"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user && !current_user.is_admin?
        flash[:danger] = "You can only do changes in your profile"
        redirect_to root_path
      end
    end

  def require_admin
      if logged_in? && !current_user.is_admin?
          flash[:danger] = "Only Admin users can perform that action"
          redirect_to root_path
      end
  end
end
