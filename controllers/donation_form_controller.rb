class DonationFormView < Watirmark::Page

  def home(model)
    Page.browser.goto( "file:///" + File.dirname(__FILE__) + "/html/donation_form.html")
  end

  def create(model)
    home(model)
  end
end

class DonationFormController < Watirmark::WebPage::Controller
  @view = DonationFormView

  def submit
    @view.submit.click
  end
end
