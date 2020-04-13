class CreateChat < ActiveRecord::Migration[4.2]
    create_table :chats do |c|
        c.integer :account_id
        c.string :location
        c.string :message
        c.string :title
        c.integer :admin
    end
end