module Watirmark
  class Session
    def check_for_post_errors
      error_message = ""
      Page.browser.elements(:class, "errorMessage").each do |e|
        error_message += e.text.strip + " " if e.text && e.text.strip != ""
      end

      raise_exception(error_message) if error_message != ""
    end

    def raise_exception(message)
      raise Watirmark::PostFailure, message.strip
    end
  end
end