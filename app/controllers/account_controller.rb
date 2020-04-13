require 'socket'
class AccountController < ApplicationController

    def new   
    end
    
    def create
        redirect_to new_account_path if params[:email] == nil
        account = {:name => params[:name],:email => params[:email],:password => params[:password]}
        @user = Account.new(account)
        if @user.valid?
            if @user.save
                session[:user_id] = @user.id
                redirect_to menu_path
            end
        else
            render 'new'
        end
    end

    def auth
        redirect_to root_path if params[:email] == nil || params[:password] == nil
        @user = Account.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to menu_path
        else
            @errors = []
            @errors << "Email can't be blank" if params[:email] == "" || params[:email] == nil
            @errors << "Password can't be blank" if params[:password] == "" || params[:password] == nil
            @errors << "Email or Password is invalid." if @user == nil && params[:email] != "" && params[:password] != ""
            render 'login'
        end
    end

    def login
        redirect_to menu_path if session[:user_id] != nil
    end

end