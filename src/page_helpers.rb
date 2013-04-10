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

  def document h1=nil, h2=nil, &block
    if h1
      html = "<h1>#{h1}</h1>\n<hr>"
      if h2
        html += "<h2>#{h2}</h2>\n"
      end
    else
      html = ""
    end
    html += block.call.strip
    html.gsub!("\n", "\\n \\ ") # multiline escape for javascript
    request = "return window.frames[0].document.getElementById('test_case_documentation').innerHTML = '#{html}'"
    $koan_browser.execute_script request
  end
end