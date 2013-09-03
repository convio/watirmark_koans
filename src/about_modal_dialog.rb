require_relative 'edgecase'

class AboutModalDialog < EdgeCase::Koan
  include Watirmark::Dialogs

  class ModalView < ModalPage
    keyword(:modalbutton) { browser.button(:id, 'opener') }
    keyword(:firstname) { browser.text_field(:id, 'first_name_text') }
    keyword(:lastname) { browser.text_field(:id, 'last_name_text') }
  end

  class ModalController < Watirmark::WebPage::Controller
    @view = ModalView

    def populate_data
      @view.modalbutton.click
      super
    end
  end

  def test_modal_dialog_exists
    show_page "modal_dialog.html"
    ModalView.new.modalbutton.click
    assert_equal __, modal_exists?
  end

  def test_modal_dialog
    show_page "modal_dialog.html"
    assert_nothing_raised do
      ModalController.new(:firstname => "Jonny",
                          :lastname => "Depp").run :create
    end
  end
end