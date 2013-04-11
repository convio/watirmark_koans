require_relative 'edgecase'

class AboutMVC < EdgeCase::Koan
  def setup
    show_page "mvc.html"
  end

  def test_about_mvc
    assert false, "Change this assertion to true to continue!"
  end

end
