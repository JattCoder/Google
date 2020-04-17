class Chat < ActiveRecord::Base
    belongs_to :account
    has_many :chatbans
    scope :allchats, -> (location) { where(location: location) }
end