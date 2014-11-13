module PageHelpers
  extend self

  def show_page name
    goto file_path(name)
    update_doc
    close_dialog if $koan_browser.windows.size > 1
  end

  def browser
    @@browser ||= begin
      Watirmark::Page.browser = $koan_browser.iframe(:id, 'example')
    end
  end

  def close_dialog
    $koan_browser.windows[1].close
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

  class ModalPage < Watirmark::Page
    def browser
      $koan_browser.windows.size > 1 ? $koan_browser : super
    end
  end
end

