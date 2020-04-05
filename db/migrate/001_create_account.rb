class CreateAccount < ActiveRecord::Migration[4.2]
    def change
        create_table :accounts do |a|
            a.string :name
            a.string :email
            a.integer :age
            a.string :password_digest
        end
    end
end