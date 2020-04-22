class Business < ActiveRecord::Base
    belongs_to :account
    has_many :items
    scope :my_business_list, -> (get_em_all) { where(account_id: get_em_all) }
    scope :delete_business, -> (business_id) { find_by(id: business_id).destroy }
    scope :get_my_business, -> (business_id) { find_by(id: business_id) }

    def self.search_businesses(input)
        @biz_search = []
        Business.all.each do |bizz|
            if bizz.name == input
                biz = {
                    "name" => bizz.name,
                    "latitude" => bizz.latitude.to_f,
                    "longitude" => bizz.longitude.to_f,
                    "type" => bizz.type,
                    "address" => bizz.address
                }
                @biz_search << biz
            end
        end
        @biz_search
    end

    def self.add_new_business(userid,params)
        location = Geocoder.address(params[:nbaddress])
        coordinates = Geocoder.coordinates(params[:nbaddress])
        if location == nil || location == "" || coordinates == nil || coordinates == ""
            @error = "Failed to find location. Please Try Again!"
            return false
        else
            bizz = {
                :account_id => userid,
                :name => params[:nbname],
                :address => location,
                :biztype => params[:nbtype],
                :latitude => coordinates[0],
                :longitude => coordinates[1]
            }
            add_bizz = new(bizz).save
        end
    end

    def self.update_business(userid,params)
        location = Geocoder.address(params[:nbaddress])
        coordinates = Geocoder.coordinates(params[:nbaddress])
        if location == nil || location == "" || coordinates == nil || coordinates == ""
            @business = Business.get_my_business(params[:id])
            @error = "Failed to find location. Please Try Again!"
            return false
        else
            business = Business.get_my_business(params[:id])
            business.name = params[:nbname]
            business.account_id = userid
            business.address = location
            business.biztype = params[:nbtype]
            business.latitude = coordinates[0]
            business.longitude = coordinates[1]
            business.save
        end
    end
end