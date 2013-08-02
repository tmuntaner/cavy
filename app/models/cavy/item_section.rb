module Cavy
  class ItemSection

    include Mongoid::Document

    field :title
    field :item_groups, type: Array

    validates :title, presence: true, uniqueness: true
  end
end
