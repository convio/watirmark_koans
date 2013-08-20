require_relative 'edgecase'

class AboutControllers < EdgeCase::Koan
  def setup
    show_page "page_object.html"
  end

  class ContactPage < Watirmark::Page
    keyword(:first_name) { browser.text_field(:id => 'first_name') }
    keyword(:last_name) { browser.text_field(:id => 'last_name') }
  end

  class ContactModel < Watirmark::Model::Factory
    keywords ContactPage.keywords

    defaults do
      first_name    {"first_#{uuid}"}
      last_name     {"last__#{uuid}"}
    end
  end

  def test_controller_and_view
    assert_nothing_raised do
      contact = Contact.new(:first_name=>'Leanne', :last_name=>'Jones')
      contact.create
    end
  end

  def test_controller_model_and_view
    contact = Contact.new
    assert_equal __(ContactModel), contact.model.class
    assert_nothing_raised do
      contact.create
    end
  end

  def test_controller_other_actions
    assert false, "CRUD operations are easy!"
  end
end