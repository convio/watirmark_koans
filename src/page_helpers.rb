module PageHelpers
  def show_page name
    goto uri_path(name)
  end

  def browser
    @@browser ||= begin
      Watirmark::Session.instance.openbrowser
      Watirmark::Page.browser.goto uri_path('koans.html')
      Watirmark::Page.browser
    end
  end

  private

  def goto(path)
    browser.execute_script "document.getElementById('page').src = \"#{path}\""
  end

  def uri_path(name)
    "file://" + File.dirname(__FILE__) + "/../html/#{name}"
  end

end