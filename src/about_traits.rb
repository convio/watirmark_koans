require_relative 'edgecase'

module Watirmark::Model

  trait :person do
    firstname {"Robby"}
    lastname  {"Smith"}
  end

  trait :address do
    street {"123 Oak Hill Lane"}
    city {"Austin"}
    state {"Texas"}
  end

  trait :credit_card do
    cardnumber {"4111111111111111"}
    cvv {"111"}
    exp_date {"05/09/2014"}
  end

  trait :donor do
    traits :person, :address, :credit_card
    amount {"10.00"}
    gift_type {"Personal"}
  end

end

class AboutTraits < EdgeCase::Koan

  def setup
    show_page "donation_form.html", "model_traits.html"
  end

  class DonationFormPage < Watirmark::Page
    keyword(:amount) { browser.text_field(:id, "amount") }
    keyword(:firstname) { browser.text_field(:id, "first_name") }
    keyword(:lastname) { browser.text_field(:id, "last_name") }
    keyword(:gift_type) { browser.select_list(:id, "giftType") }
    keyword(:street) { browser.text_field(:id, "street_name") }
    keyword(:city) { browser.text_field(:id, "city") }
    keyword(:state) { browser.select_list(:id, "state") }
    keyword(:cardnumber) { browser.text_field(:id, "credit_card") }
    keyword(:cvv) { browser.text_field(:id, "credit_card_cvv") }
    keyword(:exp_date) { browser.text_field(:id, "exp_date") }
    keyword(:submit) { browser.button(:value, "Submit") }
  end

  class Donationform < Watirmark::WebPage::Controller
    @view = DonationFormPage
  end

  class DonorModelWithOutTrait < Watirmark::Model::Factory
    keywords DonationFormPage.keywords
    defaults do
      amount { "10.00"}
      firstname { "Robby" }
      lastname { "Smith" }
      gift_type { "Personal" }
      street { "123 Oak Hill Lane" }
      city { "Austin" }
      state { "Texas" }
      cardnumber { "4111111111111111" }
      cvv { "111" }
      exp_date { "05/09/2014" }
    end
  end

  class DonorModelTrait < Watirmark::Model::Factory
    keywords DonationFormPage.keywords
    traits :donor
  end

  def test_traits_in_trait
    assert_equal __([:person, :address, :credit_card]), Watirmark::Model::Traits.instance[:donor].traits
  end

  def test_model_traits
    assert_equal __([:donor]), DonorModelTrait.new.traits
  end

  def test_model_without_trait_values
    model = DonorModelWithOutTrait.new
    assert_equal __("10.00"), model.amount
    assert_equal __("Robby"), model.firstname
    assert_equal __("Smith"), model.lastname
    assert_equal __("Personal"), model.gift_type
    assert_equal __("123 Oak Hill Lane"), model.street
    assert_equal __("Austin"), model.city
    assert_equal __("Texas"), model.state
    assert_equal __("4111111111111111"), model.cardnumber
    assert_equal __("111"), model.cvv
    assert_equal __("05/09/2014"), model.exp_date
  end

  def test_model_with_taits
    model = DonorModelTrait.new
    assert_equal __("10.00"), model.amount
    assert_equal __("Robby"), model.firstname
    assert_equal __("Smith"), model.lastname
    assert_equal __("Personal"), model.gift_type
    assert_equal __("123 Oak Hill Lane"), model.street
    assert_equal __("Austin"), model.city
    assert_equal __("Texas"), model.state
    assert_equal __("4111111111111111"), model.cardnumber
    assert_equal __("111"), model.cvv
    assert_equal __("05/09/2014"), model.exp_date
  end

  def test_model_without_traits_in_controller
    model = DonorModelWithOutTrait.new
    controller = Donationform.new(model)
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("10.00"), page.amount.value
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
    assert_equal __("Personal"), page.gift_type.value
    assert_equal __("123 Oak Hill Lane"), page.street.value
    assert_equal __("Austin"), page.city.value
    assert_equal __("Texas"), page.state.value
    assert_equal __("4111111111111111"), page.cardnumber.value
    assert_equal __("111"), page.cvv.value
    assert_equal __("05/09/2014"), page.exp_date.value
  end

  def test_model_with_traits_in_controller
    model = DonorModelTrait.new
    controller = Donationform.new(model)
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("10.00"), page.amount.value
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
    assert_equal __("Personal"), page.gift_type.value
    assert_equal __("123 Oak Hill Lane"), page.street.value
    assert_equal __("Austin"), page.city.value
    assert_equal __("Texas"), page.state.value
    assert_equal __("4111111111111111"), page.cardnumber.value
    assert_equal __("111"), page.cvv.value
    assert_equal __("05/09/2014"), page.exp_date.value
  end
end