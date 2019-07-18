module Cavy
  class Templates
    attr_reader :options

    @options = {
      string: { type: 'STRING', localize: true },
      text: { type: 'TEXT', localize: true },
      picture: { type: 'PICTURE', localize: false }
    }

    def self.localize?(option)
      value = get_option_value(option, :localize)
      return true if value
      false
    end

    def self.select_options
      @options.map { |k, v| [k.to_s, v[:type]] }
    end

    def self.get_option_value(option, field)
      return nil unless @options.key?(option.to_sym)
      @options[option.to_sym][field.to_sym]
    end
  end
end
