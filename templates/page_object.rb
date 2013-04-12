require_relative 'resources/example_template.rb'

template = Template::Example.new do
    %Q{
<table>
  <tr>
    <td align="right">First Name:</td>
    <td><input type="text" id="first_name"></td>
  </tr>
  <tr>
    <td align="right">Last Name:</td>
    <td><input type="text" id="last_name"></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td align=right><input type="submit" id="submit" value="Submit"></td>
  </tr>
</table>
}
end

puts template.generate

