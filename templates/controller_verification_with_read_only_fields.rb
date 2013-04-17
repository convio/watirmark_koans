require_relative 'lib/example_template.rb'

template = Template::Example.new do
    %Q{
<table border=0>
  <tr>
    <td align="right">First Name:</td>
    <td id="first_name">Jeanette</td>
  </tr>
  <tr>
    <td align="right">Last Name:</td>
    <td id="last_name">Winterson</td>
  </tr>
</table>
}
end

puts template.generate

