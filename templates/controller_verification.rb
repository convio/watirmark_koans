require_relative 'resources/example_template.rb'

template = Template::Example.new do
    %Q{
<table>
  <tr>
    <td align="right">First Name:</td>
    <td><input type="text" id="first_name" value="Jeanette"></td>
  </tr>
  <tr>
    <td align="right">Last Name:</td>
    <td><input type="text" id="last_name" value="Winterson"></td>
  </tr>
</table>
}
end

puts template.generate

