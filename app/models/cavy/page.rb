# == Schema Information
#
# Table name: cavy_pages
#
#  id                    :integer          not null, primary key
#  title                 :hstore
#  data                  :hstore
#  render                :string
#  route                 :string
#  page_elements         :json
#  cavy_page_template_id :integer
#  seo_description       :hstore
#  seo_keywords          :jsonb
#

module Cavy
  class Page < ::ActiveRecord::Base
    include ::Cavy::Localizable

    validates :route, uniqueness: true

    attr_accessor :tag_string, :key, :value
    attr_accessor :seo_description_string, :key, :value
    belongs_to :cavy_page_template, class_name: 'Cavy::PageTemplate'

    methods = %i[make_route check_tags check_page_elements update_render]
    methods.each do |method|
      before_save method
      before_create method
    end

    def localized_title(locale = '')
      self.title ||= {}
      localized_hash_value(self.title, locale).to_s
    end

    def set_title(new_title, locale = nil)
      locale ||= I18n.locale.to_s
      self.title[locale] = new_title
    end

    def update_page(params)
      self.title = params[:title] if params[:title].to_h != {}
      update_elements(params[:page_elements].to_h)
      update_attributes(params.except(:title, :page_elements))
    end

    def get_page_element(element, locale = nil)
      element = self.page_elements[element]
      element ||= {}
      localized_hash_value(element, locale).to_s
    end

    def title_translations
      translations = {}
      Cavy.locales.try(:each) do |alt_locale|
        translations[alt_locale] = self.title[alt_locale.to_s].to_s
      end
      translations
    end

    def get_translations(element)
      translations = {}
      Cavy.locales.try(:each) do |alt_locale|
        translations[alt_locale] = get_page_element(element, alt_locale)
      end
      translations
    end

    def update_elements(params)
      previous = self.page_elements || {}
      update_values = { page_elements: previous }

      params.try(:each) do |key, value|
        Cavy.locales.try(:each) do |alt_locale|
          localized_value = parse_page_element key, value, alt_locale
          update_values[:page_elements][key] ||= {}
          update_values[:page_elements][key][alt_locale.to_s] = localized_value unless localized_value.nil?
        end
      end

      update(update_values) if update_values != {}
    end

    def set_key_value(key, value)
      self.data = {} if self.data == nil
      self.data[key] = value
    end

    private

    def parse_page_element(key, value, locale)
      localized_value = value.is_a?(Hash) ? value[locale.to_sym] : value
      unless self.cavy_page_template.nil?
        picture_fields = self.cavy_page_template.fields.collect { |field_key, field_value| (field_value == 'PICTURE') ? field_key : nil }.compact
        localized_value = upload_image localized_value if picture_fields.include? key
      end

      localized_value
    end

    def upload_image(picture)
      return '' if picture.nil?
      uploader = Cavy.uploader || Cavy::FileUploader.new
      uploader.store!(picture)
      url = uploader.url
      Cavy::Resource.find_or_create_by(name: picture.original_filename, url: url, file_type: 'IMAGE')
      url
    end

    def check_page_elements
      self.page_elements = {} if self.page_elements.nil?
    end

    def check_tags
      self.seo_keywords = {} if self.seo_keywords.nil?
      self.seo_description = {} if self.seo_description.nil?
      self.seo_keywords[I18n.locale.to_s] = tag_string.split(',') unless tag_string.to_s == ''
      self.seo_description[I18n.locale.to_s] = seo_description_string unless seo_description_string.to_s == ''
    end

    def make_route
      self.route ||= localized_title.tr(' ', '_').downcase
    end

    def update_render
      return if self.cavy_page_template_id.nil?
      template = Cavy::PageTemplate.find(self.cavy_page_template_id)
      self.render = template.template unless template.nil?
    end

    def title_with_locale(locale)
      self.title.nil? ? nil : self.title[locale.to_s]
    end

  end
end
