require_relative "doc_helpers"

module AboutPageObjectChangesDoc
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

  def updated_page_object_view
    ruby %Q{
class ContactPage < Watirmark::Page
  keyword(:first_name) { browser.text_field(:id => "first.name") }
  keyword(:last_name)  { browser.text_field(:id => "last.name")  }
end
}
  end

  document :test_about_page_object_updates, "Page Objects", "Updating Keywords" do
    %Q{
    #{page_object_view}
    <p>In this test, we've just gotten a new release and a test that used to pass, but now fails.
       We know that the developer has made some changes to the UI so let's look there.

    <p>You should be able to inspect the HTML for any element by right clicking the element*.

    <p>Once you see the HTML you can compare it with the Watir call in the Page Object and
       update it accordingly

    <p>Look at the code for this test case and update it to work with the new UI

    <p valign=bottom>*<i>Internet Explorer will require you to install the Developer Tools<i/>
    }
  end

  document :test_about_page_object_additions, "Page Objects", "Adding Keywords" do
    %Q{
    #{updated_page_object_view}

    <p>In this release, the developer added a new field. Update the Page Object
       with a new keyword to handle populating the middle name.
    }
  end
end

