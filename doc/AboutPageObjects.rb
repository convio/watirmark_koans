require_relative "doc_helpers"

module AboutPageObjectsDocHelper
  include DocHelpers
  extend self

  def page_object_view
    ruby %Q{
class ContactPage < Watirmark::Page
  keyword(:first_name) { browser.text_field(:id => "first_name") }
  keyword(:last_name)  { browser.text_field(:id => "last_name")  }
end}
  end

  def new_page_object
    ruby %Q{
contact = ContactPage.new}
  end

  def overriding_the_browser
    ruby %Q{
contact = ContactPage.new(Watir::Browser.new)}
  end

  def global_page_context
    ruby %Q{
browser = Page.browser}
  end

  def test_about_page_objects
    document "Page Objects" do
      %Q{
         <p>Page Objects describe a design pattern that provides an interface
            between a UI interface and a class.

         <p>We use it because it allows us to refer to any UI element with a keyword and
            use that keyword in the rest of our test infrastructure. If the UI changes,
            we update it in exactly one place, the Page Object.

         <p>For this example, we define the Page as follows:
            #{page_object_view}

         <p>The page object returns the list of known keywords with the #keywords method.
      }
    end
  end

  def test_about_page_object_browser
    document "Page Objects", "Browser" do
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
  end

end

