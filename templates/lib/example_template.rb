require_relative 'doc_template'
require_relative 'form_template'
require_relative 'header_template'
require_relative 'footer_template'

module Template
  class Example
    def initialize javascript=nil, &block
      @javascript = %Q{ <script type="text/javascript" src="#{javascript}"></script>} if javascript
      @content = block
    end

    def generate
      html = Header.new(%Q{  <link href="css/example.css" rel="stylesheet" type="text/css">}, @javascript).generate
      html += Form.new(&@content).generate
      html += Doc.new.generate
      html += Footer.new.generate
    end
  end
end