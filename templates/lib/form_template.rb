require_relative 'header_template'
require_relative 'footer_template'

module Template
  class Form

    def initialize &content
      @content = content
    end

    def generate
      html = Header.new.generate
      html += (@content.call)
      html += Footer.new.generate
      html.gsub!(/^/, '  ')
      %Q{\n<div id="form" class="form">\n} + html + "</div>\n\n"
    end
  end
end
