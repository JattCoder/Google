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

    def update_biz
        if params[:nbname] == nil || params[:nbname] == "" || params[:nbaddress] == nil || params[:nbaddress] == ""
            redirect_to selectbizz_path 
        else
            location = Geocoder.address(params[:nbaddress])
            coordinates = Geocoder.coordinates(params[:nbaddress])
            if location == nil || location == "" || coordinates == nil || coordinates == ""
                @error = "Failed to find location. Please Try Again!"
                render 'add_biz'
            else
                business = Business.find_by(id: params[:id])
                business.name = params[:nbname]
                business.account_id = session[:user_id]
                business.address = location
                business.biztype = params[:nbtype]
                business.latitude = coordinates[0]
                business.longitude = coordinates[1]
                business.save
                redirect_to selectbizz_path
            end
        end
    end

    def sel_biz
        redirect_to selectbizz_path if params[:business] == nil || params[:business] == ""
        @params = params
        @items = Items.where(business_id: params[:business])
    end

    def edit_biz
        redirect_to selectbizz_path if params[:biz_id] == nil || params[:biz_id] == ""
        @business = Business.find_by(id: params[:biz_id])
    end

    def del_biz

    end

end