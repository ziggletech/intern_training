class SessionsController < ApplicationController
    def new

    end

    def create
       user = User.find_by_email(params[:session][:email])

       if user && user.authenticate(params[:session][:password])
        session[:user_id]= user.id
        flash[:success] = "Login successful"
        redirect_to user_path(user)
       else
        flash.now[:danger] = "Username or Password incorrect"
        render 'new'
       end
    end

    #log out
    def destroy
        session[:user_id]= nil
        flash[:success] = "Logged out"
        redirect_to root_path
    end
end