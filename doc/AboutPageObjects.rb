require_relative "doc_helpers"

module AboutPageObjectsDoc
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

  def subclassed_page_object_view
    ruby %Q{
class ContactPage < Watirmark::Page
  keyword(:first_name) { browser.text_field(:id => "first_name") }
  keyword(:last_name)  { browser.text_field(:id => "last_name")  }
end

class UserPage < ContactPage
  keyword(:password) { browser.text_field(:id => "password") }
  keyword(:username) { browser.text_field(:id => "username") }
end
}
 end


  def global_page_context
    ruby %Q{
def browser
  Page.browser
end
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
page.first_name.html.should ==
 '<input id="first_name" type="text" value="Suzie"></input>'
}
  end

  document :test_about_page_objects, "Page Objects" do
    %Q{
    <p>A Page Object is a design pattern providing an interface between a web page and your code.

    <p>This allows us to represent any UI element with a keyword and
      use that keyword in the rest of our test infrastructure. If the UI changes,
      we update it in exactly one place, the page object, and the rest of the code references the keyword.

    <p>For this example, a page object for the fields on the left could look like this:
      #{page_object_view}

    <p>In Watirmark we also sometimes refer to the page objects as Views since they
       represent the View portion of the Model-View-Controller design.
    }
  end

  document :test_about_page_object_browser, "Page Objects", "Browser" do
    %Q{
    #{page_object_view}

    <p>You will notice that there is a method #browser in the keyword definitions. This
      method will return the current browser context, which is automatically set by Watirmark
      when you instantiate the page.

    <p> In order to make sure we share the same browser instance across all of our tests, the Watir-Webdriver
        instance is stored in Page.browser and used in the views with:
       #{global_page_context}

    }
  end

  document :test_about_page_object_getters_and_setters, "Page Objects", "Getting and Setting Values" do
    %Q{
    #{page_object_view}

    <p>When the Page Object is instantiated, a getter and setter method are automatically created for every keyword. In this
       case the keywords are returning Watir objects so we can get and set the objects using the #value method

    #{get_and_set_values}

    <p>Of course since they are Watir objects you can also query them for anything you could do with a normal Watir element

    #{call_watir_methods}
    }
  end

  document :test_about_page_object_subclassing, "Page Objects", "Subclassing" do
    %Q{
    #{subclassed_page_object_view}

    <p> Page Objects can also be subclassed. When you create a subclass, it will automatically inherit the
        keywords defined in the parent class. So in this example, the UserPage class should also inherit the
        keywords :first_name and :last_name.
    }
  end
end

