require_relative 'edgecase'

class AboutModalDialog < EdgeCase::Koan

  def setup
    show_page "modal_dialog.html"
  end

  class ModalPage < PageHelpers::ModalPageHelper
    keyword(:modalbutton) { browser.button(:id, 'opener') }
    keyword(:firstname) { modalbrowser.text_field(:id, 'first_name_text') }
    keyword(:lastname) { modalbrowser.text_field(:id, 'last_name_text') }
    def modalbrowser
      $koan_browser
    end
  end

  def test_include_modal_dialog
    ModalPage.new.modalbutton.click
    assert_nothing_raised do
      with_modal_dialog do
        assert_equal __, true
      end
    end
  end

  def test_modal_dialog
    ModalPage.new.modalbutton.click
    with_modal_dialog do
      assert_equal __, ModalPage.new.firstname.text.empty?
      ModalPage.new.firstname = "John"
      ModalPage.new.lastname = "Doe"
      assert_equal __, ModalPage.new.firstname.value
    end
    assert false, "Modal Dialogs are no longer a difficulty."
  end



end