class CreateNeighbourhoodChat < ActiveRecord::Migration[4.2]
    create_table :chats do |c|
        c.integer :account_id
        c.string :location
        c.text :message
        c.string :title
        c.integer :creator
    end
end