class CreateBusiness < ActiveRecord::Migration[4.2]
    def change
        create_table :businesses do |b|
            b.integer :account_id
            b.string :name
            b.string :address
            b.string :biztype
            b.float :latitude
            b.float :longitude
        end
    end
end