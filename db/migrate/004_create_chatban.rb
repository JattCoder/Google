class CreateChatban < ActiveRecord::Migration[4.2]
    create_table :chatbans do |c|
        c.integer :account_id
        c.integer :chat_id
    end
end