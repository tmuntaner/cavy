FactoryGirl.define do
  factory :cavy_page, class: Cavy::Page do
    title {{
      en: "page #{Cavy::Page.count}",
      de: "seite #{Cavy::Page.count}"
    }}
    render      'cavy/pages/page'
    content     {{
      en: 'foo en',
      de: 'foo de'
    }}
    data        {}
    page_elements {}
    tags        ['foo','bar']
    description "bacon ipsum dolor sit amet #{Cavy::Page.count}"
  end
end
