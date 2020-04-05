class CreateGsearch < ActiveRecord::Migration[4.2]
    def change
        create_table :gsearchs do |s|
            s.integer :account_id
            s.string :search
        end
    end
end