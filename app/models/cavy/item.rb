module Cavy
  class Item < ActiveRecord::Base

    validates :name, presence: true
    
  end
end
