class GmapController < ApplicationController
    def map
        redirect_to root_path if session[:user_id] == nil
    end
end