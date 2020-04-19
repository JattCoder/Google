class GmapController < ApplicationController
    def map
        redirect_to root_path if session[:user_id] == nil
        @search = []
        data = JSON.load(open("https://ipapi.co/json/"))
        my_loc = Gmaps.find_by(account_id: session[:user_id])
        if my_loc
            my_loc.latitude = data["latitude"]
            my_loc.longitude = data["longitude"]
            my_loc.save
        else
            new_loc = Gmaps.new({:account_id => session[:user_id], :latitude => data["latitude"], :longitude => data["longitude"]})
            new_loc.save
        end
    end

    def results
        @search = []
        @input = params[:search]
        @client = GooglePlaces::Client.new(Rails.application.credentials.production[:api_key])
        @client.spots_by_query(params[:search]).each do |place|
            plc = {
                "name" => place.json_result_object["name"],
                "latitude" => place.json_result_object["geometry"]["location"]["lat"],
                "longitude" => place.json_result_object["geometry"]["location"]["lng"]
            }
            @search << plc
        end
        if @search == []
            Business.all.each do |bizz|
                if bizz.name == params[:search]
                    biz = {
                        "name" => bizz.name,
                        "latitude" => bizz.latitude.to_f,
                        "longitude" => bizz.longitude.to_f,
                        "type" => bizz.type,
                        "address" => bizz.address
                    }
                    @search << biz
                end
            end
        end
        render "map"
    end

    def single_biz_view
        @search = []
        bizz = Business.find_by(id: params[:biz_id])
        biz = {
            "name" => bizz.name,
            "latitude" => bizz.latitude.to_f,
            "longitude" => bizz.longitude.to_f,
            "type" => bizz.biztype,
            "address" => bizz.address
        }
        @search << biz
        location = Gmaps.new({:account_id => session[:user_id], :latitude => bizz.latitude.to_f, :longitude => bizz.longitude.to_f})
        location.save
        render 'map'
    end
end