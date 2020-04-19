class ItemController < ApplicationController

    def new
        redirect_to selectbizz_path if params[:biz_id] == nil || params[:biz_id] == ""
        @business = Business.find_by(id:params[:biz_id])
    end

    def add
        if params[:newimage] == nil || params[:newimage] == "" || params[:newname] == nil || params[:newname] == "" || params[:newcost] == nil || params[:newcost] == ""
            redirect_to selectbizz_path
        end
        new_item = {
            :business_id => params[:biz_id].to_i,
            :name => params[:newname],
            :cost => params[:newcost].to_f,
            :image => params[:newimage],
            :discription => params[:newdiscription]
        }
        item = Items.new(new_item)
        item.save
        redirect_to selbizz_path([Business.find_by(id: params[:biz_id]).name],[Business.find_by(id: params[:biz_id]).address])
    end

end