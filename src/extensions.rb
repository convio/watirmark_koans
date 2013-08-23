require 'watir-webdriver'

# stub out navigation errors
module Watirmark
  class Page
    def create(*args)
    end

    def edit(*args)
    end
  end
end

module Watirmark
  module Dialogs
    #Watir Frames do not have windows due. Watirmark's modal_exists assumes the Page
    #is a browser
    def modal_exists?
      !!($koan_browser.windows.size > 1)
    end

    def with_modal_dialog
      wait_for_modal_dialog
      parent_window = ($koan_browser.windows.size) - 2
      begin
        $koan_browser.windows.last.use
        $koan_browser.wait
        yield
      ensure
        $koan_browser.windows[parent_window].use
        Watirmark::Page.browser
      end
    end

    def wait_for_modal_dialog
      begin
        Timeout::timeout(30) {
          until modal_exists?
            sleep 0.002
          end
          $koan_browser.wait
          sleep 0.02
        }
      rescue Timeout::Error
        raise Watirmark::TestError, 'Timed out while waiting for modal dialog to open'
      end
    end
  end
end
