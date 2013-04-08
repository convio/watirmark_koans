module PageHelpers
  def show_page name
    url = "file:///" + File.dirname(__FILE__) + "/../html/#{name}"
    browser.execute_script "document.getElementById('page').src = \"#{url}\""
  end

  def browser
    @@browser ||= begin
      Watirmark::Session.instance.openbrowser
      Watirmark::Page.browser.goto "file:///" + File.dirname(__FILE__) + "/../html/koans.html"
      Watirmark::Page.browser
    end
  end

end