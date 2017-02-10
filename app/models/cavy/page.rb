module Cavy
  class Page < ::ActiveRecord::Base

    validates :route, uniqueness: true

    attr_accessor :tag_string, :key, :value

    methods = [:make_route, :check_tags, :check_page_elements]

    methods.each do |method|
      before_save method
      before_create method
    end

    def localized_title
      self.title[I18n.locale.to_s].to_s
    end

    def set_title (new_title)
      self.title[I18n.locale.to_s] = new_title
    end

    def localized_content
      if self.content
        self.content[I18n.locale.to_s].to_s
      else
        ''
      end
    end

    def set_content (new_content)
      self.content[I18n.locale.to_s] = new_content
    end

    def update_elements(params, locale = '')
      update_values = {page_elements: {}}

      self.page_elements.try(:each) do |key, value|
        update_values[:page_elements][key] = value
      end

      params.try(:each) do |key, value|
        localized_key                                = locale != '' ? key + '_' + locale : key
        update_values[:page_elements][localized_key] = (value.kind_of? String) ? value : value['value']
      end

      self.update(update_values) if update_values != {}
    end

    def set_key_value(key, value)
      self.data      = {} if self.data == nil
      self.data[key] = value
    end

    private

    def check_page_elements
      self.page_elements = {} if self.page_elements == nil
    end

    def check_tags
      unless tag_string == '' or tag_string == nil
        self.tags = tag_string.split(',')
      end

      if self.tags.kind_of? String
        self.tags = []
      end
    end

    def make_route
      self.route = self.localized_title.gsub(' ', '_').downcase if self.route.to_s == ''
    end

  end
end
