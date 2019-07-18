# == Schema Information
#
# Table name: cavy_page_templates
#
#  id         :integer          not null, primary key
#  name       :string
#  template   :string
#  fields     :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Cavy::PageTemplate, type: :model do
  describe 'field options' do
  end
end
