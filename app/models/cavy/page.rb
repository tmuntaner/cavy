module Cavy
  class Page < ActiveRecord::Base

    translates :title, :content

    validates :title, uniqueness: true, presence: true
    validates :route, uniqueness: true
    
    attr_accessor :tag_string, :key, :value

    before_save :make_route
    before_save :check_render
    before_save :check_content
    before_save :check_tags
    before_save :check_data
    before_save :check_page_elements

    def update_elements(params)
      update_values = {page_elements: {}}

      # todo find a cleaner way to update page elements, {page_elements: self.page_elements} didnt work
      self.page_elements.try(:each) do |key,value|
        update_values[:page_elements][key] = value
      end

      params.each do |key,value|
        if key == 'title' or key == 'content'
          update_values[key] = value['value']
        else
          update_values[:page_elements][key] = value['value']
        end
      end
      puts update_values
      update(update_values) if update_values != {}
    end

    def set_key_value(key,value)
      if self.data == nil
        self.data = {"#{key}" => "#{value}"}
      else
        self.data[key] = value
      end
      Cavy::Page.find(id).update(data: self.data)
    end

    private

    def check_page_elements
      self.page_elements = {} if self.page_elements == nil
    end

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
