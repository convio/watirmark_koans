require_relative "doc_helpers"

module AboutModalDialogDoc
  include DocHelpers
  extend self

  def include_modal_dialog
    ruby %Q{include Watirmark::Dialogs}
  end

  def modal_dialog_view
    ruby %Q{
class ModalPage < Watirmark::Page
  keyword(:modalbutton) { browser.button(:id, 'opener') }
  keyword(:firstname) { browser.text_field(:id, 'first_name_text') }
  keyword(:lastname) { browser.text_field(:id, 'last_name_text') }
end
    }
  end

  def show_with_modal_dialog
    ruby %Q{
with_modal_dialog do
  ModalPage.new.firstname = "John"
  ModalPage.new.lastname = "Doe"
end
    }
  end

  document :test_include_modal_dialog, "Modal Dialog" do
    %Q{
    <p>Modal Dialogs are new windows that popup from other clicking links or buttons. Watir-Webdriver focuses on the
       first browser that is opened up and when a new window pops up, it has to refocus. Watirmark allows modal
       dialogs to be handled by Watir-Webdriver smoothly.

    <p>To use the modal dialog methods, you have to first include the module.
       #{include_modal_dialog}

    <p>To continue, include the Watirmark Dialogs module

    }
  end

  document :test_modal_dialog, "Modal Dialog" do
    %Q{
      <p>From the previous lesson, you have seen the method 'with_modal_dialog'. This method allows the browser to focus
         on the new window that has popped up. Everything in the do-block will be done in the context of the popup.

      <p>The keywords in the view that are associated with the modal popup can be put into the same view as the view that
         brought up the modal dialog.

      #{modal_dialog_view}

      <p>Here, the modalbutton is connected to the button that opens the new window. Next, the firstname and lastname
         are part of the modal dialog. If you try to populate these keywords when the modal dialog is not present, then
         it will fail. To make the keywords populate correctly, with_modal_dialog must be used.

      #{show_with_modal_dialog}

      <p>After everything is executed within the block, the modal dialog will be closed.
    }
  end
end