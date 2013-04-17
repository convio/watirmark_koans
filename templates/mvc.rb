require_relative 'lib/example_template.rb'

template = Template::Example.new do
    %Q{
    <div align="center"><img src="images/mvc.png" width="300" height="300"/></div>
}
end

puts template.generate

