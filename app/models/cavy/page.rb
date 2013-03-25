module Cavy
  class Page < ActiveRecord::Base

    validates :title, uniqueness: true, presence: true
  end
end
