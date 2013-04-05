require_relative 'edgecase'

class AboutViews < EdgeCase::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal __(Array), empty_array.class
    assert_equal __(0), empty_array.size
  end
end
