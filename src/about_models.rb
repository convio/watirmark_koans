require_relative 'edgecase'

class AboutModels < EdgeCase::Koan

  def setup
    show_page "donation_form.html", "model_factory.html"
  end

  class DonationFormPage < Watirmark::Page
    keyword(:amount) { browser.text_field(:id, "amount") }
    keyword(:firstname) { browser.text_field(:id, "first_name") }
    keyword(:lastname) { browser.text_field(:id, "last_name") }
    keyword(:cardnumber) { browser.text_field(:id, "credit_card") }
    keyword(:cvv) { browser.text_field(:id, "credit_card_cvv") }
    keyword(:exp_date) { browser.text_field(:id, "exp_date") }
  end

  class DonationForm < Watirmark::WebPage::Controller
    @view = DonationFormPage
  end


  class DonationModel < Watirmark::Model::Factory
    keywords [:amount, :firstname, :lastname, :cardnumber, :cvv, :exp_date]

    defaults do
      amount { "10.00" }
      firstname { "Robby" }
      lastname { "Smith" }
      cardnumber { "4111111111111111" }
      cvv { "111" }
      exp_date { "05/09/2014" }
    end

    def full_name
      "#{firstname} #{lastname}"
    end
  end

  def test_model_defaults
    assert_equal __(true), DonationModel.new.respond_to?(:amount)
  end

  def test_model_value
    assert_equal __("10.00"), DonationModel.new.amount
  end

  def test_model_update_value
    model = DonationModel.new
    model.amount = "55.00"
    assert_equal __("55.00"), model.amount
  end

  def test_model_update
    model = DonationModel.new.update(:middlename => "Middle")
    assert_equal __(true), model.respond_to?(:middlename)
  end

  def test_model_methods
    assert_equal __("Robby Smith"), DonationModel.new.full_name
  end

  def test_model_keywords
    assert_equal __([:amount, :firstname, :lastname, :cardnumber, :cvv, :exp_date]), DonationModel.new.keywords
  end

  def test_controller_without_model
    controller = DonationForm.new({:amount => "10.00",
                                   :firstname => "Robby",
                                   :lastname => "Smith",
                                   :cardnumber => "4111111111111111",
                                   :cvv => "111",
                                   :exp_date => "05/09/2014"})
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("10.00"), page.amount.value
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
    assert_equal __("4111111111111111"), page.cardnumber.value
    assert_equal __("111"), page.cvv.value
    assert_equal __("05/09/2014"), page.exp_date.value
  end

  def test_controller_with_model
    model = DonationModel.new
    controller = DonationForm.new(model)
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("10.00"), page.amount.value
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
    assert_equal __("4111111111111111"), page.cardnumber.value
    assert_equal __("111"), page.cvv.value
    assert_equal __("05/09/2014"), page.exp_date.value
  end
end