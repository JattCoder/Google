class Account < ActiveRecord::Base
    has_secure_password
    validates :email, uniqueness: true
end