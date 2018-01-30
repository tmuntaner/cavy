module Cavy
  class ItemSection < ApplicationRecord
    validates :title, presence: true, uniqueness: true
  end
end
