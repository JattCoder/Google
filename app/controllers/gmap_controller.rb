class GmapController < ApplicationController
    def map
        redirect_to root_path if !current_user
        @search = []
        data = JSON.load(open("https://ipapi.co/json/"))
        my_loc = Gmaps.my_location(current_user.id)
        if my_loc
            my_loc.latitude = data["latitude"]
            my_loc.longitude = data["longitude"]
            my_loc.save
        else
            new_loc = Gmaps.new_location({:account_id => current_user.id, :latitude => data["latitude"], :longitude => data["longitude"]}).save
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
                "longitude" => place.json_result_object["geometry"]["location"]["lng"],
                "type" => place.json_result_object["types"][0],
                "address" => place.json_result_object["formatted_address"]
            }
            @search << plc
        end
        @search += Business.search_businesses(params[:search])
        render "map"
    end

    def single_biz_view
        @search = []
        bizz = Business.get_my_business(params[:biz_id])
        biz = {
            "name" => bizz.name,
            "latitude" => bizz.latitude.to_f,
            "longitude" => bizz.longitude.to_f,
            "type" => bizz.biztype,
            "address" => bizz.address
        }
        @search << biz
        location = Gmaps.new_location({:account_id => current_user.id, :latitude => bizz.latitude.to_f, :longitude => bizz.longitude.to_f}).save
        render 'map'
    end
end