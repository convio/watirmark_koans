require_relative 'edgecase'

module Watirmark::Model

  trait :person do
    firstname {"Robby"}
    lastname  {"Smith"}
  end

  trait :donor do
    traits :person
  end
end

class AboutTraits < EdgeCase::Koan

  def setup
    show_page "about_traits.html"
  end

  class DonationFormPage < Watirmark::Page
    keyword(:firstname) { browser.text_field(:id, "first_name") }
    keyword(:lastname) { browser.text_field(:id, "last_name") }
  end

  class Donationform < Watirmark::WebPage::Controller
    @view = DonationFormPage
  end

  class DonorModelWithOutTrait < Watirmark::Model::Factory
    keywords DonationFormPage.keywords
    defaults do
      firstname { "Robby" }
      lastname { "Smith" }
    end
  end

  class DonorModelTrait < Watirmark::Model::Factory
    keywords DonationFormPage.keywords
    traits :donor
  end

  def test_traits_in_trait
    assert_equal __([:person]), Watirmark::Model::Traits.instance[:donor].traits
  end

  def test_model_traits
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