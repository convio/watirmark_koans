require_relative 'doc_template'
require_relative 'form_template'
require_relative 'header_template'
require_relative 'footer_template'

module Template
  class Example
    def initialize &block
      @html = ""
      @content = block
    end

    def generate
      @html = Header.new(%Q{  <link href="example.css" rel="stylesheet" type="text/css">}).generate
      @html += Form.new(&@content).generate
      @html += Doc.new.generate
      @html += Footer.new.generate
    end
  end
end