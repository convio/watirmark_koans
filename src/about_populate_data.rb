require_relative "edgecase"

class AboutPopulateData < EdgeCase::Koan

  def setup
    show_page "donation_form.html", "about_populate_data.html"
  end

  class DonationFormPage < Watirmark::Page
    keyword(:amount) { browser.text_field(:id, "amount") }
    keyword(:firstname) { browser.text_field(:id, "first_name") }
    keyword(:lastname) { browser.text_field(:id, "last_name") }
    keyword(:gift_type) { browser.select_list(:id, "giftType") }
    keyword(:street) { browser.text_field(:id, "street_name") }
    keyword(:city) { browser.text_field(:id, "city") }
    keyword(:state) { browser.select_list(:id, "state") }
    keyword(:card_type,
            ["Visa"] => "A",
            ["Discover"] => "B",
            ["American Express"] => "C"
    ) { browser.radio(:name, "radgroup") }
    keyword(:cardnumber) { browser.text_field(:id, "credit_card") }
    keyword(:cvv) { browser.text_field(:id, "credit_card_cvv") }
    keyword(:exp_date) { browser.text_field(:id, "exp_date") }
    keyword(:submit) { browser.button(:value, "Submit") }
  end

  class DonationForm < Watirmark::WebPage::Controller
    @view = DonationFormPage
  end

  class DonationFormOverride < Watirmark::WebPage::Controller
    @view = DonationFormPage

    def populate_data
      @view.amount = @model.amount
      @view.firstname = @model.firstname
      @view.lastname = @model.lastname
      @view.cardnumber = @model.cardnumber
      @view.cvv = @model.cvv
      @view.exp_date = @model.exp_date
    end
  end

  def test_populate_data
    controller = DonationForm.new({:amount => "10.00",
                                   :firstname => "Robby",
                                   :lastname => "Smith",
                                   :cardnumber => "4111111111111111",
                                   :cvv => "111",
                                   :exp_date => "01/24/2014"})
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("10.00"), page.amount.value
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
    assert_equal __("4111111111111111"), page.cardnumber.value
    assert_equal __("01/24/2014"), page.exp_date.value
  end

  def test_override_populate_data
    controller = DonationFormOverride.new({:amount => "10.00",
                                           :firstname => "Robby",
                                           :lastname => "Smith",
                                           :cardnumber => "4111111111111111",
                                           :cvv => "111",
                                           :exp_date => "01/24/2014"})
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("10.00"), page.amount.value
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
    assert_equal __("4111111111111111"), page.cardnumber.value
    assert_equal __("01/24/2014"), page.exp_date.value
  end
end