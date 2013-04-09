module PageHelpers
  def show_page app_name, doc_name=nil
    if doc_name
      goto file_path(app_name), file_path(doc_name)
    else
      goto file_path(app_name)
    end
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

  def goto(app_path, doc_path="#")
    browser
    $koan_browser.execute_script "parent.document.getElementById('example').src = \"#{app_path}\""
    $koan_browser.execute_script "parent.document.getElementById('doc').src = \"#{doc_path}\""
  end

  def file_path(name)
    "file://" + File.dirname(__FILE__) + "/../html/#{name}"
  end

end