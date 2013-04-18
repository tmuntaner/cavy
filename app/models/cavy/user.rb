module Cavy
  class User

    include Mongoid::Document
    include ActiveModel::SecurePassword

    field :email
    field :name
    field :password_digest
    field :auth_token
    field :role

    has_secure_password
    has_secure_password

    validates :email, uniqueness: true, presence: true
    validates :name, presence: true
    validates :password, presence: true, on: :create

    before_create { generate_token(:auth_token)}

    @@dev_team = ['developer','designer','admin']
    @@managers = @@dev_team + ['client']
    
    def dev_team?
      return true if @@dev_team.include?(self.role)
      false
    end

    def site_manager?
      return true if @@managers.include?(self.role)
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
