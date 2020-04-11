class CreateGeo < ActiveRecord::Migration[4.2]
    def change
        create_table :gmaps do |g|
            g.integer :account_id
            g.float :latitude
            g.float :longitude
        end
    end
end