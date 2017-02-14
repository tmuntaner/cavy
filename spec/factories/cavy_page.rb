FactoryGirl.define do
  factory :cavy_page, class: Cavy::Page do |page|
    page.title { {
        en: "page #{Cavy::Page.count}",
        de: "seite #{Cavy::Page.count}"
    } }
    page.render 'cavy/pages/page'
    page.content { {
        en: 'foo en',
        de: 'foo de'
    } }
    page.data {}
    page.page_elements {}
    page.tags %w(foo bar)
    page.description "bacon ipsum dolor sit amet #{Cavy::Page.count}"
    page.association :cavy_page_template

  end
end
