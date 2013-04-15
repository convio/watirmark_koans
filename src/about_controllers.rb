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
    assert_nothing_raised do
      contact = Contact.new
      contact.create
    end
  end

  def test_controller_other_actions
    assert __(true), "CRUD operations are easy!"
  end
end

class AboutControllerVerification < EdgeCase::Koan

  class ContactPage < Watirmark::Page
    keyword(:first_name)              { browser.text_field(:id => 'first_name') }
    keyword(:last_name)               { browser.text_field(:id => 'last_name') }
    keyword(:contact_read_only_field) { |id| browser.td(:id => id)  }
  end

  class Contact < Watirmark::Page
    @view=ContactPage
  end

  def test_controller_verification
    show_page "controller_verification.html"
    contact = ContactPage.new(:first_name=>'Bob', :last_name=>'Dole')
    assert_nothing_raised { contact.verify }
  end

  def test_controller_verification_with_read_only_fields
    show_page "controller_verification_with_read_only_fields.html"
    contact = ContactPage.new(:first_name=>'Jeanette', :last_name=>'Winterson')
    assert_nothing_raised { contact.verify }
  end

  def test_controller_verification_only_keyword
    show_page "controller_verification_with_read_only_fields.html"
    assert __(true), "verification keywords make the intent clearer"
  end

end


#class AboutControllerOverrides < EdgeCase::Koan
#  def setup
#    show_page "page_object.html"
#  end
#
#  def test_controller_value_override
#end

