class ItemController < ApplicationController

    def new
        redirect_to selectbizz_path if params[:biz_id] == nil || params[:biz_id] == ""
        @business = Business.get_my_business(params[:biz_id])
    end

    def add
        if params[:newimage] == nil || params[:newimage] == "" || params[:newname] == nil || params[:newname] == "" || params[:newcost] == nil || params[:newcost] == ""
            redirect_to selectbizz_path
        end
        new_item = Items.save_new_item(params)
        redirect_to selbizz_path([Business.get_my_business(params[:biz_id]).name],[Business.get_my_business(params[:biz_id]).address])
    end

end