module Cavy
  class ItemSection < ::ActiveRecord::Base
    validates :title, presence: true, uniqueness: true
  end
end
