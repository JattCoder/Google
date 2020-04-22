class Gmaps < ActiveRecord::Base
    belongs_to :account
    scope :my_location, -> (account_id) { find_by(account_id: account_id) }
    scope :new_location, -> (data) { new(data) }
end