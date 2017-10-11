FactoryGirl.define do
  factory :cavy_page, class: Cavy::Page do |page|
    page.title { {
      en: "page #{Cavy::Page.count}",
      de: "seite #{Cavy::Page.count}"
    } }
    page.render 'cavy/pages/page'
    page.data {}
    page.page_elements { { test_en: 'test en', test_de: 'dest de' } }
    page.seo_keywords { { en: %w(foo bar), de: %w(foo bar) } }
    page.seo_description { { en: "bacon ipsum dolor sit amet #{Cavy::Page.count}", de: "bacon ipsum dolor sit amet #{Cavy::Page.count}" } }
    page.association :cavy_page_template, factory: :cavy_page_template
  end
end
