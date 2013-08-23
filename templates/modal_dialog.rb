require_relative 'lib/example_template.rb'

template = Template::Example.new do
  %Q{
<table>
  <button id="opener" onclick="open_window()">Open Dialog</button>
</table>

<script>
function open_window()
{
  window.open("modal_dialog_popup.html",'', 'width=400, height=100')
}

</script>
}
end

puts template.generate

