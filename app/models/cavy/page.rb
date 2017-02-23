module Cavy
  class Page < ::ActiveRecord::Base

    validates :route, uniqueness: true

    attr_accessor :tag_string, :key, :value
    belongs_to :cavy_page_template, class_name: 'Cavy::PageTemplate'

    methods = [:make_route, :check_tags, :check_page_elements]

    methods.each do |method|
      before_save method
      before_create method
    end

    def localized_title (locale = nil)
      locale ||= I18n.locale.to_s
      text   = self.title[locale]

      if text.to_s == '' and locale != Cavy.default_locale.to_s
        text = self.title[Cavy.default_locale.to_s]
      end

      Cavy.locales.try(:each) do |alt_locale|
        unless alt_locale.to_s == Cavy.default_locale.to_s or alt_locale.to_s == locale
          text = self.title[alt_locale.to_s]
        end
        break if text.to_s != ''
      end if text.to_s == ''
      text.to_s
    end

    def set_title (new_title, locale=nil)
      locale ||= I18n.locale.to_s

      self.title[locale] = new_title
    end

    def localized_content
      if self.content
        self.content[I18n.locale.to_s].to_s
      else
        ''
      end
    end

    def update_page (params, locale)
      if params['cavy_page_template_id'] != nil
        template = Cavy::PageTemplate.find(params[:cavy_page_template_id])
        params['render'] = template.template
      end
      self.set_title params[:title], locale if params[:title] != nil
      self.update_elements(params[:page_elements], locale)
      self.update_attributes(params.except(:title, :page_elements))
    end

    def set_content (new_content)
      self.content[I18n.locale.to_s] = new_content
    end

    def get_page_element(element, locale=nil)
      locale ||= I18n.locale.to_s
      text   = localized_page_element(element, locale)

      if text.to_s == '' and locale != Cavy.default_locale.to_s
        text = localized_page_element(element, Cavy.default_locale)
      end

      Cavy.locales.try(:each) do |alt_locale|
        unless alt_locale.to_s == Cavy.default_locale.to_s or alt_locale.to_s == locale
          text = localized_page_element(element, alt_locale)
        end
        break if text.to_s != ''
      end if text.to_s == ''

      text.to_s
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

    def localized_page_element (element, locale)
      self.page_elements[element + '_' + locale.to_s]
    end

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
