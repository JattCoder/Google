class SessionsController < ApplicationController
    
    def new
    end
    
    def create
        user = Account.find_by(email: params[:login][:email])
        if user && user.authenticate(params[:login][:password])
            session[:user_id] = user.id
            redirect_to new_gsearch_path, notice: "Logged in!"
        else
            flash.now[:alert] = "Email or password is invalid"
            render 'error'
        end
    end
    
    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "Logged out!"
    end

    def omniauth
        @user = Account.from_omniauth(auth)
        @user.save
        session[:user_id] = @user.id
        redirect_to new_gsearch_path
    end
    
    private
    
    def auth
        request.env['omniauth.auth']
    end
  
end