require_relative 'lib/example_template.rb'

template = Template::Example.new do
  %Q{
<div id="dialog" title="Example">
  <form>
    First name: <input type="text" name="firstname" id="first_name_text"><br>
    Last name: <input type="text" name="lastname" id="last_name_text"><br>
  </form>
</div>
}
end

puts template.generate

