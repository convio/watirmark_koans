module PageHelpers
  def show_page name
    browser.goto("file:///" + File.dirname(__FILE__) + "/../html/#{name}")
  end

  def browser
    @@browser ||= begin
      Watirmark::Session.instance.openbrowser
      Watirmark::Page.browser
    end
  end

end