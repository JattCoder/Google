class Chatban < ActiveRecord::Base
    belongs_to :chat
    scope :am_i_banned?, -> (account_id,chat_id) { find_by(account_id: account_id, chat_id:chat_id) }
    scope :ban_user, -> (data) { new(data) }

    def self.check_if_banned(user_id,location,title)
        chat = find_by(account_id: user_id, chat_id: Chat.find_by(title: title, location: location))
        return false if chat == nil
        return true
    end
end