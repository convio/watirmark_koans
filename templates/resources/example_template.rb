class ExampleTemplate

  def initialize
    @html = ""
  end

  def header header_content=nil
    header = "<!DOCTYPE html>\n<html>\n"
    header += "<head>\n#{header_content}\n</head>\n" if header_content
    header += "<body>\n"
  end

  def example_header
    header %Q{  <link href="example.css" rel="stylesheet" type="text/css">}
  end


  def footer
    %Q{</body>\n</html>\n}
  end

  def example &block
    @html = example_header
    instance_eval(&block)
    @html += footer
  end

  def div name, &content
    div = header
    div += (content.call)
    div += footer
    div.gsub!(/^/,'  ')
    div = %Q{\n<div id="#{name}" class="#{name}">\n} + div + "</div>\n\n"
    @html += div
  end

  def form &content
    div 'form', &content
  end

  def doc &content
    div 'doc', &content
  end
end