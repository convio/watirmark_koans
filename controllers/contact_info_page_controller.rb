class ContactInfoView < Watirmark::Page

  def home(model)
    Page.browser.goto( "file:///" + File.dirname(__FILE__) + "/html/contact_info_page.html")
  end

  def create(model)
    home(model)
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
end
