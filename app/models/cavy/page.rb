module Cavy
  class Page < ActiveRecord::Base

    validates :title, uniqueness: true, presence: true

    before_save :make_route
    before_save :check_render

    private

    def make_route
      self.route = self.title.gsub(' ', '_')
    end

    def check_render
      self.render = nil if self.render == ""
    end

  end
end
