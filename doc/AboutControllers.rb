require_relative "doc_helpers"

module AboutControllersDoc
  include DocHelpers
  extend self

  def page_object_view
    ruby %Q{
class ContactPage < Watirmark::Page
  keyword(:first_name) { browser.text_field(:id => "first_name") }
  keyword(:last_name)  { browser.text_field(:id => "last_name")  }
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

  def controller_model_view
    ruby %Q{
class Contact < Watirmark::WebPage::Controller
  @view = ContactPage
  @model = ContactModel
end
}
  end

  def model
    ruby %Q{
class ContactModel < Watirmark::Model::Factory
  keywords ContactPage.keywords

  defaults do
    first_name    {"first_\#{uuid}"}
    last_name     {"last_\#{uuid}"}
  end
end
}
  end

  def using_just_a_view
    ruby %Q{
contact = ContactView.new
contact.first_name.value = 'Fred'
contact.last_name.value = 'Flintstone'
contact.submit_button.click
assert_equal 'Fred', contact.first_name.value
assert_equal 'Flintstone', contact.last_name.value
    }
  end

  def using_a_controller
    ruby %Q{
contact = ContactPage.new(:first_name=>'Jack', :last_name=>'Black')
contact.create
contact.verify
}
  end

  def using_a_controller_with_model
    ruby %Q{
contact = ContactPage.new
contact.create
contact.verify
}
  end


  document :test_controller_and_view, "Controllers", "Making Views Efficient"  do
    %Q{
    #{page_object_view}

    <p>Up to this point, we've been able to populate our web UI by directly calling the view. Now say we
       want to populate the form and then verify all of the things we populated.
       The problem is, if we used just the view our code starts to have a very repetitive code smell

    #{using_just_a_view}

    <p>You can imagine that if the form also has the contact's address, phone, email, etc that this becomes a tiresome chore
       to code up. Furthermore, if the application UI changes then you have to manage this code as well.

    <p>To address this issue, we use controllers. The controller's job is to take in a the data you want to use
       and then do the population and verification automatically.
       The view is then parsed for all of its keywords and if a keyword has a model value, then it's used. A controller
       for our web page would look something like this:

    #{controller_view}

    <p>That's really all we have to do. Tell the controller which view to look at and let it handle everything else.
       You can then use it to handle the heavy lifting.

    #{using_a_controller}

    <p>Add a controller for this test to continue.

    }
  end

  document :test_controller_model_and_view, "Controllers", "Linking to Models" do
    %Q{
    #{page_object_view}
    #{controller_view}
    #{using_a_controller}

    <p>In the last example we had a controller connected to a view (page object) and we passed in
    the values we wanted to set. The last thing we can do is also add in a model. When we do this,
    you can still use the controller like we did above OR we can pass the controller no test data
    and use the default model values.

    <p>If this is our model
    #{model}

    <p>We connect it to the controller much like we did for the view
    #{controller_model_view}

    <p>And then we can let the controller generate it's data from the model.
    #{using_a_controller_with_model}

    <p>This is great for the most common use case of "I just need a contact and don't care about the details"

    <p>To continue, make the controller for this test case use the model to populate the fields.

    }
  end

end

