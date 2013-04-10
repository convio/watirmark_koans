require_relative 'edgecase'

class AboutModels < EdgeCase::Koan

  def setup
    show_page "page_object.html"
  end

  class DonationFormPage < Watirmark::Page
    keyword(:firstname) { browser.text_field(:id, "first_name") }
    keyword(:lastname) { browser.text_field(:id, "last_name") }
    keyword(:gift_type) { browser.select_list(:id, "gift_type")}
  end

  class DonationForm < Watirmark::WebPage::Controller
    @view = DonationFormPage
  end


  class DonationModel < Watirmark::Model::Factory
    keywords DonationFormPage.keywords

    defaults do
      firstname { "Robby" }
      lastname { "Smith" }
      gift_type { "Once" }
    end

    def full_name
      "#{firstname} #{lastname}"
    end
  end

  def test_model_defaults
    assert_equal __(true), DonationModel.new.respond_to?(:firstname)
  end

  def test_model_value
    assert_equal __("Robby"), DonationModel.new.firstname
  end

  def test_model_update_value
    model = DonationModel.new
    model.firstname = "Joey"
    assert_equal __("Joey"), model.firstname
  end

  def test_model_update
    model = DonationModel.new.update(:middlename => "Middle")
    assert_equal __(true), model.respond_to?(:middlename)
  end

  def test_model_methods
    assert_equal __("Robby Smith"), DonationModel.new.full_name
  end

  def test_model_keywords
    assert_equal __(DonationFormPage.keywords), DonationModel.new.keywords
  end

  def test_controller_without_model
    controller = DonationForm.new({:firstname => "Robby",
                                   :lastname => "Smith",
                                   :gift_type => "Once"})
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
    assert_equal __("Once"), page.gift_type.value
  end

  def test_controller_with_model
    model = DonationModel.new
    controller = DonationForm.new(model)
    controller.run :populate_data

    page = DonationFormPage.new
    assert_equal __("Robby"), page.firstname.value
    assert_equal __("Smith"), page.lastname.value
    assert_equal __("Once"), page.gift_type.value
  end
end