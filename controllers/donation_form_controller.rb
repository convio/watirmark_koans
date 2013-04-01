class DonationFormView < Watirmark::Page

  def home(model)
    Page.browser.goto( "file:///" + File.dirname(__FILE__) + "/html/donation_form.html")
  end

  def create(model)
    home(model)
  end

  def close_browser
    Page.browser.close
  end
end

class DonationFormController < Watirmark::WebPage::Controller
  @view = DonationFormView

  def submit
    @view.submit.click
  end

  def populate_data
    super
    submit
  end
end
