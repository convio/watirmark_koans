require_relative "edgecase"

class AboutPopulateData < EdgeCase::Koan

  def setup
    show_page "about_populate_data.html"
  end

  class DonationFormPage < Watirmark::Page
    keyword(:amount) { browser.text_field(:id, "amount") }
    keyword(:firstname) { browser.text_field(:id, "first_name") }
    keyword(:lastname) { browser.text_field(:id, "last_name") }
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
    end
  end

  def test_populate_data
    controller = DonationForm.new({:amount => "10.00",
                                   :firstname => "Robby",
                                   :lastname => "Smith"})
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("10.00"), page.amount.value
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
  end

  def test_override_populate_data
    controller = DonationFormOverride.new({:amount => "10.00",
                                           :firstname => "Robby",
                                           :lastname => "Smith"})
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("10.00"), page.amount.value
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
  end
end