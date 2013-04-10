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
end
