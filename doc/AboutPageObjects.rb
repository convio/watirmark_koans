require_relative "../koans/page_helpers"

module AboutPageObjectsDocHelper
  include PageHelpers
  extend self

  def page_object_view
    %Q{<pre class="ruby">

class ContactPage < Watirmark::Page
  keyword(:first_name) { browser.text_field(:id => "first_name") }
  keyword(:last_name) { browser.text_field(:id => "last_name") }
end
      </pre>}
  end

  def test_about_page_objects
    document "Page Objects" do
      %Q{
         <p>Page Objects describe a design pattern that provides an interface
            between a UI interface and a class.
         <p>We use it because it allows us to refer to any UI element with a keyword and
            use that keyword in the rest of our test infrastructure. If the UI changes,
            we can update the Page Object and not have to change any of the framework or test cases.
      }
    end
  end

  def test_use_page_objects_to_read_values_doc
    document "Page Objects", "Reading Values" do
      %Q{
         To get a value from a page object, simply
         #{page_object_view}
      }
    end
  end

  def test_use_page_objects_to_write_values_doc
    document "Page Objects" do
      "This is documentation for test_use_page_objects_to_write_values"
    end
  end

end

