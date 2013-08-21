require_relative 'edgecase'

class AboutRadioMaps < EdgeCase::Koan

  def setup
    show_page "radio_map_object.html"
  end

  class RadioPage < Watirmark::Page
    keyword(:status, {
            "On" => 0,
            "Off" => 1 #Add new value to keyword
    })                   { browser.radio(:name, "status_radio") }
  end

  def test_radio_maps_basic
    RadioPage.new.status = "On"
    assert browser.radio(:id, 'status_radio_unknown').set?, "Unknown Radio has not been set. Have you added it to the view?"
  end

  def test_radio_maps_advanced
    RadioPage.new.status = "on"
    assert browser.radio(:id, 'status_radio_unknown').set?, "Unknown Radio has not been set. Have you added another string?"
  end

end