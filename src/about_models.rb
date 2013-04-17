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
    assert_equal __("middle"), ContactModel.new.middle_name
    assert_match __(/first_/), ContactModel.new.first_name
  end

  module ::Watirmark::Model
    trait :person do
      first_name  {"first_#{uuid}" }
      last_name   {"last_#{uuid}" }
    end
  end


  #trait :donor do
  #  traits :person
  #end

  def test_model_traits
    assert_equal __([:person]), Watirmark::Model::Traits.instance[:donor].traits
  end

  def test_model_traits_containing_traits
    assert_equal __([:donor]), DonorModelTrait.new.traits
  end

  def test_model_without_trait_values
    model = DonorModelWithOutTrait.new
    assert_equal __("Robby"), model.firstname
    assert_equal __("Smith"), model.lastname
  end

  def test_model_with_taits
    model = DonorModelTrait.new
    assert_equal __("Robby"), model.firstname
    assert_equal __("Smith"), model.lastname
  end

  def test_model_without_traits_in_controller
    model = DonorModelWithOutTrait.new
    controller = Donationform.new(model)
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
  end

  def test_model_with_traits_in_controller
    model = DonorModelTrait.new
    controller = Donationform.new(model)
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
  end
end
