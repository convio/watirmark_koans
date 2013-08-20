require_relative 'edgecase'

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


