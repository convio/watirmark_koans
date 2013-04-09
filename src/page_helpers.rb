module PageHelpers
  def show_page name
    goto file_path(name)
  end

  def browser
    @@browser ||= begin
      Watirmark::Session.instance.openbrowser
      Watirmark::Page.browser.goto file_path('koans.html')
      Watirmark::Page.browser
    end
    Watirmark::Page.browser = @@browser.frame(:id, 'page')
  end


  private

  def goto(path)
    browser
    @@browser.execute_script "document.getElementById('page').src = \"#{path}\"" unless @@browser.iframe(:id, "page").src == path
  end

  def file_path(name)
    "file://" + File.dirname(__FILE__) + "/../html/#{name}"
  end

end