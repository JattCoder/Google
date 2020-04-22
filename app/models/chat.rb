class Chat < ActiveRecord::Base
    belongs_to :account
    has_many :chatbans
    scope :all_chats, -> (location) { where(location: location) }
    scope :selected_chat_messages, -> (title,location) { where(title: title, location: location) }
    scope :new_chat, -> (info) { new(info) }
    scope :chat_exists?, -> (title,location) { where(title: title, location: location) }
    scope :get_chat, -> (location,title) { find_by(location: location, title: title) }
    scope :all_messages, -> (chat_location,chat_title) { where(location: chat_location, title: chat_title) }
end