module PageHelpers
  def show_page name
    goto file_path(name)
  end

  def browser
    @@browser ||= begin
      Watirmark::Session.instance.openbrowser
      Watirmark::Page.browser.goto file_path('koans.html')
      $koan_browser = Watirmark::Page.browser
      Watirmark::Page.browser
    end
    Watirmark::Page.browser = @@browser.frame(:id, 'example')
  end


  private

  def goto(path)
    browser
    $koan_browser.execute_script "parent.document.getElementById('example').src = \"#{path}\""
  end

  def file_path(name)
    "file://" + File.dirname(__FILE__) + "/../html/#{name}"
  end

end