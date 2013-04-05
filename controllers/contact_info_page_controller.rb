class ContactInfoView < Watirmark::Page

  keyword(:submit)  { browser.button(:value, "Add Gift") }

  def home(model)
    Page.browser.goto( "file:///" + File.dirname(__FILE__) + "/../html/contact_info_page.html")
  end

  def create(model)
    home(model) unless Page.browser.url =~ /contact_info_page/
  end

  def contact_table
    Page.browser.table(:id, "contactInfoTable")
  end

  def transaction_table
    Page.browser.table(:id, "historyTable")
  end

  alias :edit :create
end

class ContactInfoController < Watirmark::WebPage::Controller
  @view = ContactInfoView

  def submit
    @view.submit.click
  end
end
