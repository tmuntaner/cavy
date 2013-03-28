module Cavy
  module Permissions

    def self.permission_for(user)
      if user == nil
        GuestPermission.new
      elsif user.role == 'admin'
        AdminPermission.new(user)
      elsif user.role == 'developer'
        DeveloperPermission.new(user)
      elsif user.role == 'designer'
        DesignerPermission.new(user)
      elsif user.role == 'client'
        ClientPermission.new(user)
      end
    end
    
  end
end