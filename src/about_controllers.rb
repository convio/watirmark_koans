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

class AboutControllerVerification < EdgeCase::Koan

  class ContactPage < Watirmark::Page
    keyword(:first_name)              { browser.text_field(:id => 'first_name') }
    keyword(:last_name)               { browser.text_field(:id => 'last_name') }
    keyword(:contact_read_only_field) { |id| browser.td(:id => id)  }
  end

  class Contact < Watirmark::WebPage::Controller
    @view=ContactPage
  end

  class ContactVerificationOverride < Watirmark::WebPage::Controller
    @view=ContactPage
  end

  def test_controller_verification
    show_page "controller_verification.html"
    contact = Contact.new(:first_name=>'Jeanette', :last_name=>'Winterson')
    assert_nothing_raised { contact.verify }
    assert false, "Verifications are easy!"
  end

  def test_controller_verification_with_read_only_fields
    show_page "controller_verification_with_read_only_fields.html"
    contact = ContactVerificationOverride.new(:first_name=>'Jeanette', :last_name=>'Winterson')
    assert_nothing_raised { contact.verify }
  end

  def test_controller_verification_only_keyword
    show_page "controller_verification_with_read_only_fields.html"
    assert false, "verification keywords make the intent clearer"
  end

end


