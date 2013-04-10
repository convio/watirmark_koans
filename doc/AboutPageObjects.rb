require_relative "doc_helpers"

module AboutPageObjectsDocHelper
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

  def new_page_object
    ruby %Q{
contact = ContactPage.new
}
  end

  def overriding_the_browser
    ruby %Q{
contact = ContactPage.new(Watir::Browser.new)
}
  end

  def global_page_context
    ruby %Q{
browser = Page.browser
}
  end

  def get_and_set_values
    ruby %Q{
page = ContactPage.new
page.first_name.value.should == 'Suzie'
page.first_name.value == "Fred"
page.first_name.value.should == 'Fred'
}
  end

  def call_watir_methods
    ruby %Q{
page = ContactPage.new
page.first_name.visible?.should be_true
page.first_name.html.should == '<input id="first_name" type="text" value="Suzie"></input>'
}
  end

  document :test_about_page_objects, "Page Objects" do
    %Q{
    <p>A Page Object is a design pattern providing an interface between a web page and your code.

    <p>We use it because it allows us to represent any UI element with a keyword and
      use that keyword in the rest of our test infrastructure. If the UI changes,
      we update it in exactly one place, the Page Object, and the rest of the code references the keyword.

    <p>For this example, we define the Page as follows:
      #{page_object_view}

    <p>The page object returns the list of known keywords with the #keywords method.
    }
  end

  document :test_about_page_object_browser, "Page Objects", "Browser" do
    %Q{
    #{page_object_view}

    <p>You will notice that there is a method #browser in the keyword definitions. This
      method will return the current browser context, which is automatically set by Watirmark
      #{new_page_object}

    <p> You can override the default browser by specifying the browser you want
       #{overriding_the_browser}

    <p> We share this browser across classes by storing it in a class method for Page
       #{global_page_context}
    }
  end

  document :test_about_page_object_getting_and_setting_values, "Page Objects", "Getting and Setting Values" do
    %Q{
    #{page_object_view}

    <p>When the Page Object is instantiated, it creates a getter and setter method for every keyword. In this
       case the keywords are returning Watir objects so we can get and set the objects using the #value method

    #{get_and_set_values}

    <p>Of course since they are Watir objects you can also query them for anything you could do with a normal Watir element

    #{call_watir_methods}
    }
  end
end
