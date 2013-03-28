module Cavy
  class Page < ActiveRecord::Base

    validates :title, uniqueness: true, presence: true

    before_save :make_route
    before_save :check_render
    before_save :check_content

    private

    def check_content
      self.content = "" if self.content == nil
    end
    
    def make_route
      self.route = self.title.gsub(' ', '_') if self.route == "" or self.route == nil
    end

    def check_render
      self.render = nil if self.render == ""
    end

  end
end
