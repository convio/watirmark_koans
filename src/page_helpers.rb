module PageHelpers
  def show_page name
    goto file_path(name)
    update_doc
  end

  def browser
    @@browser ||= begin
      Watirmark::Page.browser = $koan_browser.frame(:id, 'example')
    end
  end


  private

  def goto(path)
    browser
    $koan_browser.execute_script "parent.document.getElementById('example').src = \"#{path}\""
  end

  def file_path(name)
    "file://" + File.dirname(__FILE__) + "/../html/#{name}"
  end

  def open_browser
    Watirmark::Session.instance.openbrowser
    $koan_browser = Watirmark::Page.browser
    $koan_browser.goto file_path('koans.html')
    $koan_browser.window.resize_to(930, 1100)
  end

  class ModalPageHelper < Watirmark::Page
    def modalbrowser
      $koan_browser
    end
  end
end

