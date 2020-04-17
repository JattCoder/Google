class BusinessController < ApplicationController

    def mybizzes
        @bizz = Business.where(account_id: session[:user_id])
    end

    def add_biz
        if params[:nbname] == nil || params[:nbname] == "" || params[:nbaddress] == nil || params[:nbaddress] == ""
            render 'add_biz' 
        else
            location = Geocoder.address(params[:nbaddress])
            coordinates = Geocoder.coordinates(params[:nbaddress])
            if location == nil || location == "" || coordinates == nil || coordinates == ""
                @error = "Failed to find location. Please Try Again!"
                render 'add_biz'
            else
                bizz = {
                    :account_id => session[:user_id],
                    :name => params[:nbname],
                    :address => location,
                    :biztype => params[:nbtype],
                    :latitude => coordinates[0],
                    :longitude => coordinates[1]
                }
                add_bizz = Business.new(bizz)
                add_bizz.save
                redirect_to selectbizz_path
            end
        end
    end

    def sel_biz
        binding.pry
    end

    def biz_items

    end

    def del_biz

    end

end