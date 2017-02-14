FactoryGirl.define do
  factory :cavy_page_template, class: 'Cavy::PageTemplate' do |page_template|
    page_template.name 'MyString'
    page_template.template 'MyString'
    page_template.fields({ element: 'STRING', content: 'TEXT'})
  end
end
