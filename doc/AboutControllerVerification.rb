require_relative "doc_helpers"

module AboutControllerVerificationDoc
  include DocHelpers
  extend self

  def create_contact
    ruby %Q{
contact = ContactPage.new(:first_name=>'Jeanette', :last_name=>'Winterson')
contact.create
}
  end

  def verify_contact
    ruby %Q{
contact.verify
}
  end

  def page_object_view
    ruby %Q{
class ContactPage < Watirmark::Page
  keyword(:first_name)              { browser.text_field(:id => "first_name") }
  keyword(:last_name)               { browser.text_field(:id => "last_name")  }
  keyword(:contact_read_only_field) { |id| browser.td(:id => id)  }
end
}
  end

  def controller_view
    ruby %Q{
class Contact < Watirmark::WebPage::Controller
  @view = ContactPage
end
}
  end

  def page_object_view_with_verify_keyword
    ruby %Q{
class ContactPage < Watirmark::Page
  keyword(:first_name)                     { browser.text_field(:id => "first_name") }
  keyword(:last_name)                      { browser.text_field(:id => "last_name")  }
  verify_keyword(:contact_read_only_field) { |id| browser.td(:id => id)  }
end
}
  end

  def controller_override_verify
    ruby %Q{
class Contact < Watirmark::WebPage::Controller
  @view = ContactPage

  def verify_first_name
    assert @view.contact_read_only_field('first_name').text == @model.first_name
  end

  def verify_last_name
    assert @view.contact_read_only_field('last_name').text == @model.last_name
  end

end
}
  end


  document :test_controller_verification, "Controllers", "Verification" do
    %Q{
    <p>For this form, let's assume we've navigated to the edit page and want to verify that
       adding our new contact works properly. We created the contact with:

    #{create_contact}

    <p>So to verify we simply:

    #{verify_contact}

    <p>That will go through each value in the model and make sure the current values of the HTML elements
       match the values provided.
    }
  end

  document :test_controller_verification_with_read_only_fields, "Controllers", "Verification Overrides" do
    %Q{
    <p>Applications, of course are not always so formulaic. There are cases where some items are
       editable and others are either generated or only writable on creation. For these items, we
       need to override how things are verified.

    <p>To do this, we add a callback method to our controller. Before any keyword element is verified, Watirmark
       checks the controller to see if you've defined a method "verify_ELEMENT_NAME". If that method exists,
       then it gets called in place of what it would normally have done.

    <p>Look at the HTML on the left pane. You'll see that in this page, the values are stored in a table.
       To access them, let's add a new keyword. This time, we'll create a special form of keyword that
       accepts an input parameter.

    #{page_object_view}

    <p>Passing in a parameter is great. All of the fields are formatted exactly the same way so it reduces unecessary code.

    <p>Now to update the controller to use this. We'll create an override for both the first and last names.

    #{controller_override_verify}

    <p>Now when the verification is running, it will see that you've provided a method to override verifications of that field
       and it will run that code instead. If most of the page was like this, you probably wouldn't want
       to override every field, you would instead create a new controller designed for that page and
       pass in the same model you used to create the record. These overrides are just intended for smaller
       corner cases.
    }
  end

  document :test_controller_verification_only_keyword, "Controllers", "verify_keyword" do
    %Q{
    <p>In the previous example we created a keyword just for verification. To make sure we don't actually
       use this for anything else, we can scope the keyword by creating it as a 'verify_keyword'

    #{page_object_view_with_verify_keyword}

    <p>There are two other types of keywords: 'populate_keyword' used for create/edit and 'private_keyword'
       which are keywords passed in but not directly populated. We'll show examples of each of those later.
    }
  end
end

