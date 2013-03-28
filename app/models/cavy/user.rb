module Cavy
  class User < ActiveRecord::Base

    has_secure_password

    validates_presence_of :email
    validates_uniqueness_of :email

    validates_presence_of :name
    
    validates_presence_of :password, :on => :create

    before_create { generate_token(:auth_token)}

    @@dev_team = ['developer','designer','admin']
    
    def dev_team?
      return true if @@dev_team.include?(self.role)
      false
    end

    private

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.where(column => self[column]).exists?
    end

  end
end
