require_relative 'lib/example_template.rb'

template = Template::Example.new do
  %Q{
<table>
  <tr valign="top">
    <td>
      <input type="radio" name="status_radio" id="status_radio_on" value="0" checked="checked">
      <label for="status_radio_on"> On </label>
    </td>
  </tr>
  <tr valign="top">
    <td>
      <input type="radio" name="status_radio" id="status_radio_off" value="1">
      <label for="status_radio_off"> Off </label>
    </td>
  </tr>
  <tr valign="top">
    <td>
      <input type="radio" name="status_radio" id="status_radio_unknown" value="2">
      <label for="status_radio_unknown"> Unknown </label>
    </td>
  </tr>
</table>
}
end

puts template.generate

