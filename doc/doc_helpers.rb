module DocHelpers

  def document method, h1=nil, h2=nil, &block
    define_method method do
      if h1
        html = "<h1>#{h1}</h1>\n<hr>"
        if h2
          html += "<h2>#{h2}</h2>\n"
        end
      else
        html = ""
      end
      html += block.call.strip
      html = escape_multiline(html)
      html = escape_apostrophes(html)
      request = "parent.window.frames[0].document.getElementById('test_case_documentation').innerHTML = '#{html}'"
      $koan_browser.execute_script request
    end
  end

  def ruby code
    %Q{<pre class="ruby">

#{code.strip}
</pre>}
  end

  private

  def escape_multiline html
    html.gsub!("\n", "\\n \\ ")
  end

  def escape_apostrophes html
    html.gsub!("'", "\\\\'")
  end


end