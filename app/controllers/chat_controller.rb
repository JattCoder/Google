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
        redirect_to root_path if session[:user_id] == nil
        render 'new' if params[:ntitle] == nil || params[:ntitle] == ""
        data = JSON.load(open("https://ipapi.co/json/"))
        location = "#{data['city']}, #{data['region']}"
        msg = "t-"+params[:nmessage]
        new_chat = {
            :account_id => session[:user_id],
            :location => location,
            :message => msg,
            :title => params[:ntitle],
            :admin => session[:user_id]
        }
        chat = Chat.find_by(title: params[:ntitle], location: location)
        if chat
        else
            chat = Chat.new(new_chat)
            chat.save
        end
        redirect_to showchat_path(id: chat.id, title: chat.title)
    end

    def show
        banned = Chatban.find_by(account_id: session[:user_id], chat_id: Chat.find_by(id: params[:id]).id)
        if banned
            redirect_to account_menu_chats_path
        end
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
        msg = "m-"+params[:nmessage]
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
        @params = params
        @allUsers = []
        @admin = Account.find_by(id: Chat.find_by(id: params[:id]).admin)
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
        @inactive = Chatban.where(chat_id: params[:id].to_i)
    end

    def ban
        if params[:user_id].to_i != Chat.find_by(id: params[:id]).admin
            account_menu_chats_path
        end
        banned = Chatban.find_by(account_id: params[:userid], chat_id: params[:id])
        if banned
            banned.destroy
        else
            banned = Chatban.new({account_id: params[:userid], chat_id: params[:id]})
            banned.save
        end
        account_menu_chats_path
    end

    def delete
        redirect_to root_path if session[:user_id] == nil
        redirect_to account_menu_chats_path if params[:id] == nil || params[:id] == ""
        chat = Chat.where(title: params[:title], location: params[:location])
        chat.destroy_all
        redirect_to account_menu_chats_path
    end

end