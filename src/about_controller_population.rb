require_relative 'edgecase'

class AboutControllerPopulation < EdgeCase::Koan

  class DonorView < Watirmark::Page
    keyword(:amount)        { browser.text_field(:id, "donation_amount") }
    keyword(:first_name)    { browser.text_field(:id, "first_name") }
    keyword(:last_name)     { browser.text_field(:id, "last_name") }
    keyword(:check_payment) { browser.radio(:id, "check_payment_method")}
    keyword(:credit_payment) { browser.radio(:id, "credit_payment_method")}
    keyword(:check_number)  { browser.text_field(:id, "check_number") }
    keyword(:credit_card)   { browser.text_field(:id, "card_number") }
    keyword(:cvv)           { browser.text_field(:id, "cvv_number") }
    navigation_keyword(:payment_type) {}
  end

  class DonorModel < Watirmark::Model::Factory
    keywords DonorView.keywords

    defaults do
      amount {"10.00"}
      first_name {"first_#{uuid}"}
      last_name {"last_#{uuid}"}
    end
  end

  def test_populate_data_override
    show_page "donation_page.html"
    assert_nothing_raised do
      donor = DonorModel.new
      donor.payment_type = "Check"
      donor.check_number = "123456789"
      DonorPopulateData.new(donor).create
    end
  end

  def test_populate_keyword
    show_page "donation_page.html"
    assert_nothing_raised do
      donor = DonorModel.new
      donor.payment_type = "Credit"
      donor.credit_card = "4111111111111111"
      donor.cvv = "111"
      DonorPopulateKeyword.new(donor).create
    end
  end
end


