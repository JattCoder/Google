class Account < ActiveRecord::Base
    has_secure_password
    validates :email, uniqueness: true

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
          user.name = auth.info.name
          user.email = auth.info.email
          user.password = SecureRandom.hex
        end
    end
end