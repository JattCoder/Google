class Business < ActiveRecord::Base
    belongs_to :account
    has_many :items
end