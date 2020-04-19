class Account < ActiveRecord::Base
    has_many :chats
    has_many :businesss
    has_many :gmaps, through: :businesss
    has_many :items, through: :businesss
    has_many :chatbans, through: :chats
    has_secure_password
    validates :email, uniqueness: true
    validates :email, :password, :name, :presence => true
    validates :password, :length => { :minimum => 6 }
    scope :account, -> (email) { find_by(email: email) }

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
          user.name = auth.info.name
          user.email = auth.info.email
          user.password = SecureRandom.hex
        end
    end
end