require 'socket'
class AccountController < ApplicationController
    
    def create
        account = {:name => params[:register][:name],:email => params[:register][:email],:password => params[:register][:password]}
        @user = Account.new(account)
        if @user.valid?
            if @user.save
                redirect_to sessions_path
            end
        else
            redirect_to new_account_path
        end
    end

    def login
        redirect_to menu_path if session[:user_id] != nil
    end

end