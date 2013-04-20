module Cavy
  class ItemSection

    include Mongoid::Document

    field :title

    has_many :item_groups

    validates :title, presence: true, uniqueness: true
  end
end
