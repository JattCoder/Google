class ChatController < ApplicationController

    def index
        @data = JSON.load(open("https://ipapi.co/json/"))
        @location = "#{@data['city']}, #{@data['region']}"
        @allChats = Chat.allchats(@location)
        @username = Account.find_by(id: session[:user_id]).name
    end

    def new
    end

    def create
        render 'new' if params[:title] == nil || params[:title] == ""
        data = JSON.load(open("https://ipapi.co/json/"))
        location = "#{data['city']}, #{data['region']}"
        msg = "t-"+params[:message]
        new_chat = {
            :account_id => session[:user_id],
            :location => location,
            :message => msg,
            :title => params[:title],
            :admin => session[:user_id]
        }
        @any = Chat.find_by(title: params[:title], location: location)
        if @any
            redirect_to showchat_path(id: @any.id, title: @any.title)
        else
            chat = Chat.new(new_chat)
            chat.save
            redirect_to account_menu_chats_path
        end
    end

    def show
        @selection = "#{params[:id]},#{params[:title]}"
        @allChats = Chat.where(location: Chat.find_by(id: @selection.split(",")[0]).location, title: @selection.split(",")[1])
    end

    def reply
        redirect_to account_menu_chats_path if params[:id] == nil || params[:id] == ""
        @data = Chat.find_by(id: params[:id])
    end

    def submit
        redirect_to account_menu_chats_path if params[:id] == nil || params[:id] == ""
        reply_to = Chat.find_by(id: params[:id])
        msg = "m-"+params[:message]
        new_reply = {
            :account_id => session[:user_id],
            :location => reply_to.location,
            :message => msg,
            :title => params[:title],
            :admin => session[:user_id]
        }
        reply = Chat.new(new_reply)
        reply.save
        redirect_to showchat_path([params[:id]],[params[:title]])
    end

    def participants
        redirect_to account_menu_chats_path if params[:id] == nil || params[:id] == ""
        @allUsers = []
        Chat.where(title: Chat.find_by(title: params[:title]).title, location: Chat.find_by(id: params[:id]).location).each do |message|
            user = Account.find_by(id: message.account_id)
            userdata = {
                :id => user.id,
                :name => user.name,
                :email => user.email
            }
            @allUsers << userdata
        end
        @allUsers = @allUsers.uniq!
    end

    def destroy

    end

end