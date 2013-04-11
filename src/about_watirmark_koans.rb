require_relative 'edgecase'

class AboutWatirmarkKoans < EdgeCase::Koan
  def setup
    show_page "watirmark_koans.html"
  end

  def test_about_watirmark_koans
    assert false, "Change this assertion to true to continue!"
  end

end
