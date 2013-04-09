require_relative 'resources/example_template.rb'

template = ExampleTemplate.new.example do
  form do
    %Q{
<table>
  <tr>
    <td align="right">First Name:</td>
    <td><input type="text" id="first_name" value="Suzie"></td>
  </tr>
  <tr>
    <td align="right">Last Name:</td>
    <td><input type="text" id="last_name" value="Smith"></td>
  </tr>
  <tr>
    <td align="right">Gift Type:</td>
    <td>
      <select id="gift_type">
      <option value="Once">Once</option>
      <option value="Recurring">Recurring</option>
      </select>
    </td>
  </tr>
  <tr>
    <td align="right">Remember me:</td>
    <td><input type="checkbox" id="remember_me"></td>
  </tr>
</table>
}
  end

  doc do
    %Q{
<h1>Page Objects</h1>
<div id="test_case_documentation"/>
}
  end
end


puts template
