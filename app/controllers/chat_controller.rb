class ChatController < ApplicationController

    def index
        @data = JSON.load(open("https://ipapi.co/json/"))
        @location = "#{@data['city']}, #{@data['region']}"
        @allChats = Chat.all_chats(@location)
        @username = current_user.name
    end

    def new
    end

    def create
        redirect_to root_path if !current_user
        render 'new' if params[:ntitle] == nil || params[:ntitle] == "" || params[:nmessage] == nil
        data = JSON.load(open("https://ipapi.co/json/"))
        location = "#{data['city']}, #{data['region']}"
        msg = "t-"+params[:nmessage]
        new_chat = {
            :account_id => current_user.id,
            :location => location,
            :message => msg,
            :title => params[:ntitle],
            :admin => current_user.id
        }
        chat = Chat.chat_exists?(params[:ntitle],location).length
        if chat == 0
            chat = Chat.new_chat(new_chat)
            chat.save
        end
        redirect_to account_menu_chats_path
    end

    def show
        banned = Chatban.check_if_banned(current_user.id,params[:location], params[:title])
        if banned == true
            redirect_to account_menu_chats_path
        end
        @allChats = Chat.all_messages(params[:location],params[:title])
    end

    def reply
        redirect_to account_menu_chats_path if params[:location] == nil || params[:location] == "" || params[:title] == nil || params[:title] == ""
        @data = Chat.get_chat(params[:location],params[:title])
    end

    def submit
        if params[:location] == nil || params[:location] == "" || params[:title] == nil || params[:title] == ""
            render 'reply'
        else
            msg = "m-"+params[:nmessage]
            new_reply = {
                :account_id => current_user.id,
                :location => params[:location],
                :message => msg,
                :title => params[:title],
                :admin => Chat.get_chat(params[:location],params[:title]).admin
            }
            reply = Chat.new_chat(new_reply).save
            redirect_to showchat_path([params[:title]],params[:location])
        end
    end

    def participants
        redirect_to account_menu_chats_path if params[:title] == nil || params[:title] == ""
        @params = params
        @allUsers = []
        @admin = Account.chat_admin(Chat.get_chat(params[:format], params[:title]).admin)
        Chat.selected_chat_messages(params[:title],params[:format]).each do |message|
            user = Account.find_by(id: message.account_id)
            userdata = {
                :id => user.id,
                :name => user.name,
                :email => user.email
            }
            @allUsers << userdata
        end
        @allUsers = @allUsers.uniq
        @inactive = Chatban.where(chat_id: params[:id].to_i)
    end

    def ban
        if current_user.id == Chat.get_chat(params[:location],params[:title]).admin
            banned = Chatban.am_i_banned?(params[:userid],params[:id])
            if banned
                banned.destroy
            else
                banned = Chatban.ban_user({account_id: params[:userid], chat_id: params[:id]}).save
            end
        end
        redirect_to chatusers_path([params[:title]])
    end

    def delete
        redirect_to root_path if !current_user
        redirect_to account_menu_chats_path if params[:id] == nil || params[:id] == ""
        chat = Chat.selected_chat_messages(params[:title],params[:location])
        @error = ""
        if current_user.id == chat[0].admin.to_i
            chat.destroy_all
        end
        redirect_to account_menu_chats_path
    end

end