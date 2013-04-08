require_relative 'edgecase'

class AboutPageObjects < EdgeCase::Koan
  def setup
    show_page "page_object.html"
  end

  class DonationPage < Watirmark::Page
    keyword(:first_name) { browser.text_field(:id => 'first_name') }
    keyword(:last_name) { browser.text_field(:id => 'last_name') }
    keyword(:gift_type) { browser.select_list(:id => 'gift_type') }
    keyword(:remember_me) { browser.checkbox(:id => 'remember_me') }
    keyword(:submit) { browser.button(:id => 'gift_type') }
  end

  def test_use_page_objects_to_read_values
    page = DonationPage.new
    page.first_name.value = "Suzie"
    assert_equal __('Suzie'), page.first_name.value
  end

  def test_use_page_objects_to_write_values
    page = DonationPage.new
    assert_equal __('Once'), page.gift_type.value
    page.gift_type = 'Recurring'
    assert_equal __('Recurring'), page.gift_type.value
  end
end
