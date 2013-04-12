require_relative 'resources/example_template.rb'

template = Template::Example.new do
    %Q{
<table>
  <tr>
    <td align="right">First Name:</td>
    <td><input type="text" id="first.name" value=""></td>
  </tr>
  <tr>
    <td align="right">Middle Name:</td>
    <td><input type="text" id="middle.name" value=""></td>
  </tr>
  <tr>
    <td align="right">Last Name:</td>
    <td><input type="text" id="last.name" value=""></td>
  </tr>
</table>
}
end

puts template.generate

