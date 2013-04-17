require_relative 'edgecase'

class AboutModels < EdgeCase::Koan

  class ContactPage < Watirmark::Page
    keyword(:first_name) { browser.text_field(:id, "first.name") }
    keyword(:middle_name) { browser.text_field(:id, "middle.name") }
    keyword(:last_name) { browser.text_field(:id, "last.name") }
  end

  class ContactModel < Watirmark::Model::Factory
    keywords ContactPage.keywords

    defaults do
      first_name  {"first_#{uuid}" }
      middle_name {"middle"}
      last_name   {"last_#{uuid}" }
    end
  end

  class Contact < Watirmark::WebPage::Controller
    @view = ContactPage
  end

  def setup
    show_page "page_object_addition.html"
  end

  def test_model_basics
    model = ContactModel.new
    assert_equal __("middle"), model.middle_name
    assert_match __(/first_/), model.first_name
    model.first_name = 'Wilma'
    assert_equal __, model.first_name
  end

  module ::Watirmark::Model
    trait :person do
      first_name  {"first_#{uuid}" }
      last_name   {"last_#{uuid}" }
    end
  end

  class ContactModelWithTraits < Watirmark::Model::Factory
    keywords ContactPage.keywords
  end

  def test_model_traits
    assert_match __(/first_/), ContactModelWithTraits.new.first_name
  end

  def test_model_traits_containing_traits
    assert_equal false, "Nested traits make it easier to maintain models."
  end
end
