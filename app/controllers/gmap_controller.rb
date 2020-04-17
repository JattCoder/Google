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

    def biz_view
        @search = []
        Business.all.each do |bizz|
            biz = {
                "name" => bizz.name,
                "latitude" => bizz.latitude.to_f,
                "longitude" => bizz.longitude.to_f
            }
            @search << biz
        end
        render "map"
    end
end