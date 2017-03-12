module Cavy
  class Page < ::ActiveRecord::Base

    validates :route, uniqueness: true

    attr_accessor :tag_string, :key, :value
    attr_accessor :seo_description_string, :key, :value
    belongs_to :cavy_page_template, class_name: 'Cavy::PageTemplate'

    methods = [:make_route, :check_tags, :check_page_elements, :update_render]

    methods.each do |method|
      before_save method
      before_create method
    end

    def localized_title (locale = nil)
      locale ||= I18n.locale.to_s
      text = self.title[locale.to_s]

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

    def update_page (params, locale)
      self.title = params[:title] if params[:title].to_h != {}
      self.update_elements(params[:page_elements].to_h, locale)
      self.update_attributes(params.except(:title, :page_elements))
    end

    def set_content (new_content)
      self.content[I18n.locale.to_s] = new_content
    end

    def get_page_element(element, locale=nil)
      locale ||= I18n.locale.to_s
      text = localized_page_element(element, locale)

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

    def get_title_translations
      translations = {}
      Cavy.locales.try(:each) do |alt_locale|
        translations[alt_locale] = self.title[alt_locale.to_s].to_s
      end
      translations
    end

    def get_translations (element)
      translations = {}
      Cavy.locales.try(:each) do |alt_locale|
        translations[alt_locale] = localized_page_element(element, alt_locale)
      end
      translations
    end

    def update_elements(params, locale = nil)
      locale ||= I18n.locale.to_s
      update_values = {page_elements: {}}

      self.page_elements.try(:each) do |key, value|
        update_values[:page_elements][key] = value
      end

      params.try(:each) do |key, value|
        locales = (value.is_a?(Hash)) ? Cavy.locales.collect { |alt_locale| alt_locale.to_s } : [locale]
        locales.try(:each) do |alt_locale|
          localized_key, localized_value = parse_page_element key, value, alt_locale
          update_values[:page_elements][localized_key] = localized_value unless localized_value.nil?
        end
      end

      self.update(update_values) if update_values != {}
    end

    def set_key_value(key, value)
      self.data = {} if self.data == nil
      self.data[key] = value
    end

    private

    def parse_page_element (key, value, locale)
      localized_key = key.to_s + '_' + locale
      localized_value = (value.is_a? Hash) ? value[locale.to_sym] : value
      unless self.cavy_page_template.nil?
        picture_fields = self.cavy_page_template.fields.collect { |field_key, field_value| (field_value == 'PICTURE') ? field_key : nil }.compact
        localized_value = upload_image localized_value if picture_fields.include? key
      end
      return localized_key, localized_value
    end

    def localized_page_element (element, locale)
      self.page_elements[element + '_' + locale.to_s].to_s
    end

    def upload_image (picture)
      return '' if picture.nil?
      uploader = Cavy.uploader || Cavy::FileUploader.new
      uploader.store!(picture)
      uploader.url
    end

    def check_page_elements
      self.page_elements = {} if self.page_elements == nil
    end

    def check_tags
      self.seo_keywords = {} if self.seo_keywords.nil?
      self.seo_description = {} if self.seo_description.nil?

      self.seo_keywords[I18n.locale.to_s] = tag_string.split(',') unless tag_string.to_s == ''
      self.seo_description[I18n.locale.to_s] = seo_description_string unless seo_description_string.to_s == ''
    end

    def make_route
      self.route = self.localized_title.gsub(' ', '_').downcase if self.route.to_s == ''
    end

    def update_render
      unless self.cavy_page_template_id.nil?
        template = Cavy::PageTemplate.find(self.cavy_page_template_id)
        self.render = template.template unless template.nil?
      end
    end

  end
end
