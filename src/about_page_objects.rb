require_relative 'edgecase'

class AboutPageObjects < EdgeCase::Koan
  def setup
    show_page "page_object.html"
  end

  class ContactPage < Watirmark::Page
    keyword(:first_name) { browser.text_field(:id => 'first_name') }
    keyword(:last_name) { browser.text_field(:id => 'last_name') }
  end

  def test_about_page_objects
    assert_equal __([:first_name, :last_name]), ContactPage.new.keywords
  end

  def test_about_page_object_browser
    page = ContactPage.new
    assert_equal __(true), page.browser == Page.browser
  end

  def test_about_page_object_getters_and_setters
    page = ContactPage.new
    assert_equal __("Suzie"), page.first_name
    page.first_name = "Fred"
    assert_equal __("Fred"), page.first_name
  end

  def test_about_page_object_subclassing
    page = UserPage.new
    assert_equal __([:first_name, :last_name, :username, :password]), page.keywords
  end
end
