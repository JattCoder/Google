class BusinessController < ApplicationController

    def mybizzes
        @bizz = Business.my_business_list(current_user.id)
    end

    def add_biz
        if params[:nbname] == nil || params[:nbname] == "" || params[:nbaddress] == nil || params[:nbaddress] == ""
            render 'add_biz'
        else
            add_new_biz = Business.add_new_business(current_user.id,params)
            if add_new_biz == false
                render 'add_biz' 
            else
                redirect_to selectbizz_path
            end
        end
    end

    def update_biz
        if params[:nbname] == nil || params[:nbname] == "" || params[:nbaddress] == nil || params[:nbaddress] == ""
            redirect_to selectbizz_path 
        else
            update_biz = Business.update_business(current_user.id,params)
            binding.pry
            redirect_to selectbizz_path
        end
    end

    def sel_biz
        redirect_to selectbizz_path if params[:business] == nil || params[:business] == ""
        @params = params
        @items = Items.business_items(params[:business])
    end

    def edit_biz
        redirect_to selectbizz_path if params[:biz_id] == nil || params[:biz_id] == ""
        @business = Business.get_my_business(params[:biz_id])
    end

    def del_biz
        Business.delete_business(params[:biz_id])
        Items.business_items(params[:biz_id]).destroy_all
        redirect_to selectbizz_path
    end

end