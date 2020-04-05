class AccountController < ApplicationController
    
    def create
        account = {:name => params[:register][:name],:email => params[:register][:email],:age => params[:register][:age].to_i,:password => params[:register][:password]}
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
        
    end

end