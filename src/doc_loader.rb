DOC_DIR = File.dirname(__FILE__) + '/../doc'
Dir.glob("#{DOC_DIR}/*").each do |doc|
  filename = File.basename(doc)
  next unless filename =~ /^About/
  require_relative "../doc/#{filename}"
end
