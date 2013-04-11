module DocHelpers

  def document method, h1=nil, h2=nil, &block
    define_method method do
      if h1
        if h2
          title = "#{h1} - #{h2}"
        else
          title = h1
        end
        html = "<h1>#{title}</h1>\n<hr>"
      else
        html = ""
      end
      html += block.call.strip
      html = escape_multiline(html)
      html = escape_apostrophes(html)
      puts html
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
    html
  end

  def escape_apostrophes html
    html.gsub!("'", "\\\\'")
    html
  end


end