require_relative 'edgecase'

class AboutPageObjects < EdgeCase::Koan

  class PretendWebPage
    attr_accessor :text_field, :select_list, :radio, :checkbox
  end
  Page.browser = PretendWebPage.new

  def test_a_page_object_is_an_interface_to_a_web_page
    assert_equal 1, 1
  end

  def test_simple_view_should_show_keywords
    assert_equal __(:name), MyPage.keywords.first
  end

  def test_simple_view_should_create_getter_and_setter_methods
    assert_equal __(true), MyPage.respond_to?(:name)
    assert_equal __(true), MyPage.respond_to?(:name=)

  end

  def test_simple_view_should_show_keywords
    assert_equal __("Hello World"), SimpleView.name
  end

  class MyEmptyPage < Watirmark::Page
  end

  def test_empty_view
    assert_equal __(Array), NoKeywords.keywords
  end
end
