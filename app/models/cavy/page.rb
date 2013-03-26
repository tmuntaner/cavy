module Cavy
  class Page < ActiveRecord::Base

    validates :title, uniqueness: true, presence: true

    after_save :make_route

    private

    def make_route
      self.route = self.title.gsub(' ', '_')
    end

  end
end
