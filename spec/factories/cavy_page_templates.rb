FactoryGirl.define do
  factory :cavy_page_template, class: 'Cavy::PageTemplate' do |page_template|
    page_template.sequence(:name) { |n| "page template #{n}" }
    page_template.sequence(:template) { |n| "template #{n}" }
    page_template.fields({ element: 'STRING', content: 'TEXT' })
  end
end
