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

FactoryGirl.define do
  factory :cavy_page_template, class: 'Cavy::PageTemplate' do |page_template|
    page_template.sequence(:name) { |n| "page template #{n}" }
    page_template.sequence(:template) { |n| "template #{n}" }
    page_template.fields(element: 'STRING', content: 'TEXT')
  end
end
