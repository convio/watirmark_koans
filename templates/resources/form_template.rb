require_relative 'header_template'
require_relative 'footer_template'

module Template
  class Form

    def initialize &content
      @content = content
    end

    def generate
      div = Header.new.generate
      div += (@content.call)
      div += Footer.new.generate
      div.gsub!(/^/, '  ')
      %Q{\n<div id="form" class="form">\n} + div + "</div>\n\n"
    end
  end
end
