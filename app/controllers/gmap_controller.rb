class GmapController < ApplicationController
    def map
        redirect_to root_path if session[:user_id] == nil
        @search = []
        data = JSON.load(open("https://ipapi.co/json/"))
        location = Gmaps.new({:account_id => session[:user_id], :latitude => data["latitude"], :longitude => data["longitude"]})
        location.save
    end

    def results
        @search = []
        places = Geocoder.search(params[:search]).each do |place|
            plc = {
                "name" => place.data["display_name"],
                "latitude" => place.data["lat"].to_f,
                "longitude" => place.data["lon"].to_f
            }
            @search << plc
        end
        render "map"
    end

    #<% @geos = [[41.429958,-81.696899],[0,0],[21.429958,41.696899]]; %>
end