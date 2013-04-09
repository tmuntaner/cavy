module Cavy
  class Page < ActiveRecord::Base

    validates :title, uniqueness: true, presence: true
    validates :route, uniqueness: true
    
    attr_accessor :tag_string, :key, :value

    before_save :make_route
    before_save :check_render
    before_save :check_content
    before_save :check_tags
    before_save :check_data

    def set_key_value(key,value)
      if self.data == nil
        self.data = {"#{key}" => "#{value}"}
      else
        self.data[key] = value
      end
      Cavy::Page.find(id).update(data: self.data)
    end

    private

    def check_tags
      unless tag_string == '' or tag_string == nil
        self.tags = tag_string.split(',')
      end
    end


    def check_content
      self.content = "" if self.content == nil
    end
    
    def make_route
      self.route = self.title.gsub(' ', '_').downcase if self.route == nil or self.route == ''
    end

    def check_render
      self.render = nil if self.render == ""
    end

    def check_data
      self.data = {} if self.data == nil
    end

  end
end
