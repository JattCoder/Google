class GsearchController < ApplicationController
    def new
        redirect_to root_path if session[:user_id] == nil
    end
end