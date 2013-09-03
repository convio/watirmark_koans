require_relative "doc_helpers"

module AboutModalDialogDoc
  include DocHelpers
  extend self

  def modal_exists
    ruby %Q{modal_exists?}
  end

  def with_modal_dialog
    ruby %Q{
with_modal_dialog do
  # populate dialog here
end
    }
  end

  document :test_modal_dialog_exists, "Modal Dialog" do
    %Q{
    <p>Modal Dialogs are new windows that popup from either clicking links or buttons. Watirmark focuses on the
       first browser that is opened up and when a new window pops up, it has to refocus to the new browser. With
       Watirmarks Dialog module, it allows modal dialogs to be handled by Watir-Webdriver smoothly.

    <p>With the method #{modal_exists} it is easy to determine if there is a modal dialog present.
    }
  end

  document :test_modal_dialog, "Modal Dialog" do
    %Q{
    <p>That was simple. Its just as easy to run populate actions on Modal Dialogs as well.

    #{with_modal_dialog}

    <p>The method with_modal_dialog allows you to pass in a block of code that would be used to populate a
    page object just as you normally would if there were no dialogs present. What this method does is it refocuses
    the browser object to the dialog window. This gives your view object access to the dialogs page objects when you call
    browser.text_field or browser.checkbox.

    <p>To continue you need to update the ModalController's populate_data method to use the with_modal_dialog in order
    to populate first and last name successfully.
    }
  end
end