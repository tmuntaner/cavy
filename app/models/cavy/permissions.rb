module Cavy
  module Permissions
    def self.permission_for(user)
      if user == nil
        GuestPermission.new
      else
        AdminPermission.new(user)
      end
    end
  end
end