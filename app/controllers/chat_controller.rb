class ChatController < ApplicationController

    def index
        @data = JSON.load(open("https://ipapi.co/json/"))
        @location = "#{@data['city']}, #{@data['region']}"
        @allChats = Chat.where(location: @location)
        @username = Account.find_by(id: session[:user_id]).name
    end

    def new
    end

    def create
        render 'new' if params[:title] == nil
        data = JSON.load(open("https://ipapi.co/json/"))
        location = "#{data['city']}, #{data['region']}"
        new_chat = {
            :account_id => session[:user_id],
            :location => location,
            :message => params[:message],
            :title => params[:title],
            :admin => session[:user_id]
        }
        @any = Chat.find_by(title: params[:title], location: location)
        if @any
            redirect_to account_menu_chats_path
        end
        chat = Chat.new(new_chat)
        chat.save
        redirect_to account_menu_chats_path
    end

    def show
        @allChats = Chat.where(location: params[:location], title: params[:title])
        

    end

    def destroy

    end

end