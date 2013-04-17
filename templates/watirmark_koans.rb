require_relative 'lib/example_template.rb'

template = Template::Example.new do
  %Q{
<p>This pane will show you a sample web page or some interesting code
<table>
  <tr>
    <td align="right">Text Field:</td>
    <td><input type="text" id="text"></td>
  </tr>
  <tr>
    <td align="right">Select List:</td>
    <td>
      <select id="select_list">
      <option value="first">first item</option>
      <option value="second">second item</option>
      </select>
    </td>
  </tr>
  <tr>
    <td align="right">Checkbox:</td>
    <td><input type="checkbox" id="checkbox"></td>
  </tr>
</table>
}
end

puts template.generate

