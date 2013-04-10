begin
  require File.dirname(__FILE__) + "/../src/page_helpers"
rescue LoadError
  require File.dirname(__FILE__) + "/../koans/page_helpers"
end

module AboutPageObjectsDocHelper
  include PageHelpers
  extend self

  def test_use_page_objects_to_read_values_doc
    document do
      "This is documentation for test_use_page_objects_to_read_values"
    end
  end

  def test_use_page_objects_to_write_values_doc
    document do
      "This is documentation for test_use_page_objects_to_write_values"
    end
  end

end

