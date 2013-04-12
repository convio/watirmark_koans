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
    page.first_name.value = "Fred"
    assert_equal __("Fred"), page.first_name.value
  end

  class UserPage < ContactPage
    keyword(:password) { browser.text_field(:id => "password") }
    keyword(:username) { browser.text_field(:id => "username") }
  end

  def test_about_page_object_subclassing
    page = UserPage.new
    assert_equal __([:first_name, :last_name, :username, :password]), page.keywords.sort
  end
end


class AboutPageObjectChanges < EdgeCase::Koan
  class ContactPage < Watirmark::Page
    keyword(:first_name) { browser.text_field(:id => 'first_name') }
    keyword(:last_name)  { browser.text_field(:id => 'last_name') }
  end

  def test_about_page_object_updates
    show_page "page_object_update.html"
    page = ContactPage.new
    assert_nothing_raised do
      page.first_name = "Sally"
    end
  end

  def test_about_page_object_additions
    show_page "page_object_addition.html"
    page = ContactPage.new
    assert_nothing_raised do
      page.middle_name = "Alexander"
    end
  end
end
