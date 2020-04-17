class CreateItem < ActiveRecord::Migration[4.2]
    def change
        create_table :items do |i|
            i.integer :business_id
            i.string :name
            i.float :cost
            i.string :discription
            i.string :image
        end
    end
end